//
//  ViewController.swift
//  OpenWeatherMap API Demo
//
//  Created by Janne Lehikoinen on 06/03/2019.
//  Copyright © 2019 Janne Lehikoinen. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // IBOutlets
    @IBOutlet weak var tempLabel: NSTextField!
    @IBOutlet weak var weatherDescLabel: NSTextField!
    
    /// Get weather information using OpenWeatherMap API.
    ///
    /// Case example of HTTP GET request:
    /// 1. Call APIModel _getLocationWeatherData_ method using shared APIModel instance using endpoint uri as a parameter. The shared instance is needed for returning values from the _printResultsClosure_ closure inside _getLocationWeatherData_ method.
    /// 2. _printResultsClosure_ method then uses the HTTPMethods _getRequest_ method to make the actual GET request.
    /// 3. Requested JSON data is then parsed in _printResultsClosure_ closure inside _getLocationWeatherData_ method.
    /// 4. Weather information is finally returned from the _getLocationWeatherData_ method and added to the  text fields.
    func getWeatherInformation() {
        
        APIModel.sharedInstance.getLocationWeatherData(endpoint: Globals.targetEndpoint) { WeatherData in
            
            let location = WeatherData.location
            let temp = WeatherData.temperature
            var description = WeatherData.description
            print("Location: \(location)")
            print("Temp: \(temp)")
            print("Desc: \(description)")
            
            // If API call or JSON parsing failed
            if !(WeatherData.errorMsg!.isEmpty) {
                description = WeatherData.errorMsg!
            }
            
            // Handle temperature
            let roundedTemp = round(temp)
            var tempString = String(roundedTemp)
            if roundedTemp > 0.0 {
                tempString = "+" + tempString + " °C"
            } else {
                tempString = tempString + " °C"
            }
            
            //  Update UI on main queue when this closure is ready
            DispatchQueue.main.async {
                self.view.window?.title = location
                self.tempLabel.stringValue = tempString
                self.weatherDescLabel.stringValue = description
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getWeatherInformation()
    }
    
    override func viewDidAppear() {
        
        // Customize main window
        let window = self.view.window
        window?.backgroundColor = NSColor.controlBackgroundColor
        window?.styleMask.insert(NSWindow.StyleMask.unifiedTitleAndToolbar)
        window?.toolbar?.isVisible = false
        window?.titlebarAppearsTransparent = true
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
