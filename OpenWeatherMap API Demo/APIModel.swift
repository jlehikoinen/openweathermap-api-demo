//
//  APIModel.swift
//  OpenWeatherMap API Demo
//
//  Created by Janne Lehikoinen on 07/03/2019.
//  Copyright © 2019 Janne Lehikoinen. All rights reserved.
//

import Cocoa

// Openweathermap location endpoint
struct LocationWeather: Codable {
    
    let clouds: Clouds
    let name: String
    let visibility: Int?
    let sys: System
    let weather: [Weather]
    let coord: Coordinates
    let base: String
    let dt: Int
    let main: Main
    let id: Int
    let wind: Wind
    let cod: Int
}

struct Clouds: Codable {
    
    let all: Int
}

struct System: Codable {
    
    let country: String
    let sunset: Int
    let message: Double
    let type: Int
    let id: Int
    let sunrise: Int
}

struct Weather: Codable {
    
    let main: String
    let id: Int
    let icon: String
    let description: String
}

struct Coordinates: Codable {
    
    let lat: Double
    let lon: Double
}

struct Main: Codable {
    
    let pressure: Int
    let tempMin: Double
    let tempMax: Double
    let temp: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case pressure
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case temp
        case humidity
    }
}

struct Wind: Codable {
    
    let speed: Double
    let deg: Int?
}
// Openweathermap location endpoint data ends here

// Openweathermap API model
struct APIModel {
    
    /// Singleton pattern used here
    ///
    /// Static APIModel instance for returning values from closure
    static var sharedInstance = APIModel()
    
    func getLocationWeatherData(endpoint: String, completion: @escaping (WeatherData) -> ()) {
        
        // Vars
        var location = ""
        var temp = 0.0
        var description = ""
        var errorMsg = ""
        
        // Use Generic HTTP method
        let printResultsClosure: HTTPMethods.dataFromURLCompletionClosure = {data, response, error in
            
            guard let responseData = data else {
                print("Error: Did not receive any data")
                return
            }
            
            // Decode JSON data
            let decoder = JSONDecoder()
            do {
                let jsonData = try decoder.decode(LocationWeather.self, from: responseData)
                
                // No error checking..
                location = jsonData.name
                temp = jsonData.main.temp
                description = jsonData.weather[0].description
                
            } catch {
                print("Error: Could not decode JSON: \(error)")
                print("Missing API key?")
                errorMsg = "Error: Could not decode JSON"
            }
            
            // Instance of WeatherData struct
            let weatherData = WeatherData(location: location, temperature: temp, description: description, errorMsg: errorMsg)
            
            // "Return" instance of WeatherData struct
            completion(weatherData)
        }
        // Make the connection
        let newConnection = HTTPMethods()
        newConnection.getRequest(endpoint, handler: printResultsClosure)
    }
}

