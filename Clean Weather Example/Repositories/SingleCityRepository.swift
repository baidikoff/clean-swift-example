//
//  SingleCityRepository.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

struct WeatherForecast: Hashable {
    let city: WeatherCity
    let forecast: Forecast
}

struct Forecast: Hashable, Codable {
    let name: String
    let time: Date
    let id: Int
    let main: MainForecast
    
    enum CodingKeys: String, CodingKey {
        case name
        case time = "dt"
        case id
        case main
    }
}

struct MainForecast: Hashable, Codable {
    let humidity: Double
    let pressure: Double
    let temperature: Double
    let maxTemperature: Double
    let minTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case pressure
        case temperature = "temp"
        case maxTemperature = "temp_max"
        case minTemperature = "temp_min"
    }
}

class SingleCityRepository {
    let sessionManager = SessionManager.default
    
    private lazy var decoder: JSONDecoder = {
       let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }()
    
    func getWeather(city: WeatherCity) -> Observable<WeatherForecast> {
        return self.sessionManager.rx
            .data(.get, "https://api.openweathermap.org/data/2.5/weather", parameters: ["q": city.name, "appid": "8295a9dd99881beeb3563180dc3f29ca", "units": "metric"])
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .utility))
            .map { data in
                let forecast = try self.decoder.decode(Forecast.self, from: data)
                return WeatherForecast(city: city, forecast: forecast)
            }
    }
}
