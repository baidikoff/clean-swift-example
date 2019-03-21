//
//  SingleCityViewModel.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import DITranquillity
import RxSwift

class SingleCityViewModel {
    private let city: WeatherCity
    private let repository: SingleCityRepository
    private let graphQLRepository: GraphQLRepository
    
    private let bag = DisposeBag()
    
    private lazy var forecast = self.repository.getWeather(city: self.city).share()
    
    private(set) lazy var pairs = Variable<[Pair]>([])
    
    init(city: WeatherCity, container: DIContainer = appContainer) {
        self.city = city
        self.repository = container.resolve()
        self.graphQLRepository = container.resolve()
        
        self.graphQLRepository.getAllPairs().subscribe(onNext: { [weak self] pairs in
            guard let strongSelf = self else { return }
            strongSelf.pairs.value = pairs
        }).disposed(by: self.bag)
        
        self.graphQLRepository.pairSubscription().subscribe(onNext: { [weak self] (pair, mutationType) in
            guard let strongSelf = self else { return }
            
            switch mutationType {
            case .created:
                strongSelf.pairs.value.append(pair)
            case .deleted:
                if let index = strongSelf.pairs.value.firstIndex(of: pair) {
                    strongSelf.pairs.value.remove(at: index)
                }
            case .updated:
                if let index = strongSelf.pairs.value.index(where: { $0.id == pair.id }) {
                    strongSelf.pairs.value[index] = pair
                }
            default: break
            }
        }).disposed(by: self.bag)
    }
    
    func update(pair: Pair, newFirst: String, newSecond: String) {
        self.graphQLRepository.pairMutation(pair: pair, newFirst: newFirst, newSecond: newSecond)
    }
    
    func temperature() -> Observable<String> {
        return self.forecast.map { "Temperature = \(Int($0.forecast.main.temperature)) °C" }
    }
    
    func humidity() -> Observable<String> {
        return self.forecast.map { "Humidity = \(Int($0.forecast.main.humidity)) %" }
    }
    
    func reload() {
        self.forecast = self.repository.getWeather(city: self.city).share()
    }
}
