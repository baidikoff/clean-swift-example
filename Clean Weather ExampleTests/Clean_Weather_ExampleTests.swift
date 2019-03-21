//
//  Clean_Weather_ExampleTests.swift
//  Clean Weather ExampleTests
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
import DITranquillity
@testable import Clean_Weather_Example


class BaseTest: XCTestCase {
    let testsContainer = DIContainer()
    
    override func setUp() {
        super.setUp()
        self.setDependencies()
    }
    
    override func tearDown() {
        super.tearDown()
        testsContainer.clean()
    }
    
    func setDependencies() {}
}

class FakeSingleCityRepository: SingleCityRepository {
    override func getWeather(city: WeatherCity) -> Observable<WeatherForecast> {
        return Observable.create({ (subscribe) -> Disposable in
            let mainForecast = MainForecast(humidity: 1.0, pressure: 1.0, temperature: 5.0, maxTemperature: 1.0, minTemperature: 1.0)
            subscribe.onNext(WeatherForecast(city: city, forecast: Forecast(name: "", time: Date(), id: 1, main: mainForecast)))
            return Disposables.create()
        })
    }
}

class Clean_Weather_ExampleTests: BaseTest {
    override func setDependencies() {
        self.testsContainer.register(FakeSingleCityRepository.init).as(SingleCityRepository.self)
    }
    
    func test() {
        let viewModel = SingleCityViewModel(city: WeatherCity(name: "Kyiv"), container: self.testsContainer)
        
        XCTAssertEqual(try viewModel.humidity().toBlocking().first(), "Humidity = 1 %")
        XCTAssertEqual(try viewModel.temperature().toBlocking().first(), "Temperature = 5 °C")
    }
}
