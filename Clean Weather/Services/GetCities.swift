//
//  GetCities.swift
//  Clean Weather
//
//  Created by Nick Baidikoff on 3/5/19.
//  Copyright © 2019 Nick Baidikoff. All rights reserved.
//

import Foundation

struct GetCitiesEndpoint: Endpoint {
    typealias ResponseType = [WeatherCity]
    
    let resourceName: String = "/cities"
}
