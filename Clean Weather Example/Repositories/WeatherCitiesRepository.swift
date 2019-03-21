//
//  WeatherCitiesRepository.swift
//  Clean Weather Example
//
//  Created by dandy on 3/20/19.
//  Copyright © 2019 dandy. All rights reserved.
//

import Foundation

struct WeatherCity: Hashable {
    let name: String
}

class WeatherCitiesRepository {
    func getCities() -> [WeatherCity] {
        return [WeatherCity(name: "Kyiv"), WeatherCity(name: "Kharkiv"), WeatherCity(name: "Odessa")]
    }
}
