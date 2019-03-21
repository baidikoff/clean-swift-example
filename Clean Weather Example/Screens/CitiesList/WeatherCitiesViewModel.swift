//
//  WeatherCitiesViewModel.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import RxSwift

class WeatherCitiesViewModel {
    private let repository: WeatherCitiesRepository = appContainer.resolve()
    
    private lazy var observable = Observable<[WeatherCity]>.create { (observer) -> Disposable in
        observer.onNext(self.repository.getCities())
        return Disposables.create()
    }
    
    func citiesList() -> Observable<[WeatherCity]> {
        return self.observable
    }
}
