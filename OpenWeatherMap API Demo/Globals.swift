//
//  Constants.swift
//  OpenWeatherMap API Demo
//
//  Created by Janne Lehikoinen on 08/03/2019.
//  Copyright © 2019 Janne Lehikoinen. All rights reserved.
//

struct Globals {

    // Check these from https://openweathermap.org
    static let apiKey = "add-api-key-here"
    static let locationId = "658225"                // Helsinki
    static let units = "metric"

    // Endpoint uri
    static let targetEndpoint = "http://api.openweathermap.org/data/2.5/weather?id=" + locationId + "&&units=" + units + "&appid=" + apiKey
}
