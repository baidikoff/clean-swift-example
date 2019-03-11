//
//  GetCitiesListUseCase.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 2/18/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct GetCitiesListUseCase: DataAsyncUseCase {
    typealias Output = [WeatherCity]
    
    private let repository: CitiesRepository = container.resolve()
    
    func action() -> Single<[WeatherCity]> {
        return self.repository.getSities()
    }
}
