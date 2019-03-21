//
//  Apollo+Rx.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import RxSwift
import Apollo

/// An `Error` emitted by `ApolloReactiveExtensions`.
public enum RxApolloError: Error {
    /// One or more `GraphQLError`s were encountered.
    case graphQLErrors([GraphQLError])
}

/// Reactive extensions for `ApolloClient`.
public final class ApolloReactiveExtensions {
    private let client: ApolloClient
    
    fileprivate init(_ client: ApolloClient) {
        self.client = client
    }
    
    /// Fetches a query from the server or from the local cache, depending on the current contents of the cache and the specified cache policy.
    ///
    /// - Parameters:
    ///   - query: The query to fetch.
    ///   - cachePolicy: A cache policy that specifies when results should be fetched from the server and when data should be loaded from the local cache.
    ///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
    /// - Returns: A `Maybe` that emits the results of the query.
    public func fetch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        queue: DispatchQueue = .main
    )
        -> Maybe<Query.Data>
    {
        return Maybe.create { maybe in
            let cancellable = self.client.fetch(query: query, cachePolicy: cachePolicy, queue: queue) { result, error in
                if let error = error {
                    maybe(.error(error))
                } else if let errors = result?.errors {
                    maybe(.error(RxApolloError.graphQLErrors(errors)))
                } else if let data = result?.data {
                    maybe(.success(data))
                } else {
                    maybe(.completed)
                }
            }
            
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
    
    /// Watches a query by first fetching an initial result from the server or from the local cache, depending on the current contents of the cache and the specified cache policy. After the initial fetch, the returned `Observable` will emit events whenever any of the data the query result depends on changes in the local cache.
    ///
    /// - Parameters:
    ///   - query: The query to watch.
    ///   - cachePolicy: A cache policy that specifies when results should be fetched from the server or from the local cache.
    ///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
    /// - Returns: An `Observable` that emits the results of watching the `query`.
    public func watch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy = .returnCacheDataElseFetch,
        queue: DispatchQueue = .main
    )
        -> Observable<Query.Data>
    {
        return Observable.create { observer in
            let watcher = self.client.watch(query: query, cachePolicy: cachePolicy, queue: queue) { result, error in
                if let error = error {
                    observer.onError(error)
                } else if let errors = result?.errors {
                    observer.onError(RxApolloError.graphQLErrors(errors))
                } else if let data = result?.data {
                    observer.onNext(data)
                }
                
                // Should we silently ignore the case where `result` and `error` are both nil, or should this be an error situation?
            }
            
            return Disposables.create {
                watcher.cancel()
            }
        }
    }
    
    /// Performs a mutation by sending it to the server.
    ///
    /// - Parameters:
    ///   - mutation: The mutation to perform.
    ///   - queue: A dispatch queue on which the result handler will be called. Defaults to the main queue.
    /// - Returns: A `Maybe` that emits the results of the mutation.
    public func perform<Mutation: GraphQLMutation>(
        mutation: Mutation,
        queue: DispatchQueue = .main
    )
        -> Maybe<Mutation.Data>
    {
        return Maybe.create { maybe in
            let cancellable = self.client.perform(mutation: mutation, queue: queue) { result, error in
                if let error = error {
                    maybe(.error(error))
                } else if let errors = result?.errors {
                    maybe(.error(RxApolloError.graphQLErrors(errors)))
                } else if let data = result?.data {
                    maybe(.success(data))
                } else {
                    maybe(.completed)
                }
            }
            
            return Disposables.create {
                cancellable.cancel()
            }
        }
    }
    
    public func subscribe<Subscription: GraphQLSubscription>(
        subscription: Subscription,
        queue: DispatchQueue = .main
    )
        -> Observable<Subscription.Data>
    {
        return Observable.create({ (observer) -> Disposable in
            let cancellable = self.client.subscribe(subscription: subscription, queue: queue, resultHandler: { (result, error) in
                if let error = error {
                    observer.onError(error)
                } else if let errors = result?.errors {
                    observer.onError(RxApolloError.graphQLErrors(errors))
                } else if let data = result?.data {
                    observer.onNext(data)
                } else {
                    observer.onCompleted()
                }
            })
            
            return Disposables.create {
                cancellable.cancel()
            }
        })
    }
}

public extension ApolloClient {
    /// Reactive extensions.
    var rx: ApolloReactiveExtensions { return ApolloReactiveExtensions(self) }
}
