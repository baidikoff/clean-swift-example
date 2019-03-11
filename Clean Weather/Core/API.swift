//
//  API.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 2/18/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import Foundation

import Alamofire
import RxSwift
import RxCocoa

protocol Endpoint {
    associatedtype ResponseType: Codable
    
    var resourceName: String { get }
    var parameters: Parameters? { get }
    var headers: [String: String]? { get }
    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    var headers: [String: String]? { return nil }
    var parameters: Parameters? { return nil }
    
    var encoding: ParameterEncoding { return URLEncoding.default }
}

struct API {
    
    let baseUrl: String
    private let manager: Alamofire.SessionManager
    
    private let queue = DispatchQueue(label: "api")
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        self.manager = Alamofire.SessionManager(configuration: URLSessionConfiguration.default)
    }
    
    func request<Response, EndpointType: Endpoint>(_ endpoint: EndpointType) -> Single<Response> where EndpointType.ResponseType == Response {
        return Single.create { observer in
            let url = self.buildUrl(endpoint)
            let request = self.manager.request(url,
                                               method: .get,
                                               parameters: endpoint.parameters,
                                               encoding: endpoint.encoding,
                                               headers: endpoint.headers)
            
            print("Executing request \(url)")
            
            request
                .validate()
                .responseData(queue: self.queue) { response in
                    let result = response.result.flatMap { data -> EndpointType.ResponseType in
                        return try JSONDecoder().decode(EndpointType.ResponseType.self, from: data)
                    }
                    
                    switch result {
                    case let .success(value): observer(.success(value))
                    case let .failure(error): observer(.error(error))
                    }
            }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    private func buildUrl<EndpointType: Endpoint>(_ endpoint: EndpointType) -> String {
        return self.baseUrl + endpoint.resourceName
    }
}
