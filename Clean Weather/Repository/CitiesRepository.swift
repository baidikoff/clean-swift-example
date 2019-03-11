//
//  CitiesRepository.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 3/5/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CitiesRepository {
    func getSities() -> Single<[WeatherCity]>
}

struct APICitiesRepository: CitiesRepository {
    
    private let api: API = container.resolve()
    
    func getSities() -> Single<[WeatherCity]> {
        return self.api.request(GetCitiesEndpoint())
    }
}
