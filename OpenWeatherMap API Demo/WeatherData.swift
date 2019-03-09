//
//  WeatherData.swift
//  OpenWeatherMap API Demo
//
//  Created by Janne Lehikoinen on 08/03/2019.
//  Copyright © 2019 Janne Lehikoinen. All rights reserved.
//

// Small container for weather information
struct WeatherData {
    
    let location: String
    let temperature: Double
    let description: String
    let errorMsg: String?
}
