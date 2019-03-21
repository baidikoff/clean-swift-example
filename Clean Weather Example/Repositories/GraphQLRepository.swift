//
//  GraphQLRepository.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import Apollo
import DITranquillity
import RxSwift
import RxOptional

struct Pair: Hashable, Codable {
    let id: String
    let first: String
    let second: String
}

typealias MutationType = _ModelMutationType

class GraphQLRepository {
    private let client: ApolloClient
    private let bag = DisposeBag()
    
    convenience init() {
        self.init(container: appContainer)
    }
    
    init(container: DIContainer) {
        self.client = container.resolve()
    }
    
    func getAllPairs() -> Observable<[Pair]> {
        return self.client.rx
            .fetch(query: GetAllPairsQuery())
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .map { $0.allPairs.map { Pair(id: $0.id, first: $0.first, second: $0.second) } }
            .asObservable()
    }
    
    func pairMutation(pair: Pair, newFirst: String, newSecond: String) {
        self.client.rx
            .perform(mutation: UpdatePairMutation(id: pair.id, first: newFirst, second: newSecond))
            .subscribe()
            .disposed(by: self.bag)
    }
    
    func pairSubscription() -> Observable<(Pair, MutationType)> {
        return self.client.rx
            .subscribe(subscription: PairMutationSubscription())
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .map { $0.pair?.node != nil ? (node: $0.pair!.node!, mutation: $0.pair!.mutation) : nil }
            .filterNil()
            .map { (Pair(id: $0.node.id, first: $0.node.first, second: $0.node.second), $0.mutation) }
    }
}
