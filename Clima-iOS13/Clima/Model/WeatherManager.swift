//
//  WeatherManager.swift
//  Clima
//
//  Created by Saurabh Kumar Verma on 10/07/2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(Constants.apiKey)&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
//        print(urlString)
        
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    
    // URLSession to fetch the data
    func performRequest(with urlString : String){
        // 1. Create a URL
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            // let task = session.dataTask(with: url, completionHandler: handle(data: response: error:))
            // OR
            // we use above code by using closure
            let task = session.dataTask(with: url) { data, response, error in
                if(error != nil){
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
//                    let dataString = String(data: safeData, encoding: .utf8)
//                    print(dataString ?? "0")
                    if let weather = self.parseJSON(safeData){
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            // Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task.
            task.resume()
        }
    }
    
//    func handle(data: Data?, response: URLResponse?, error: Error?) -> Void {
//        if(error != nil){
//            print(error!)
//            return
//        }
//
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//            print(dataString ?? "0")
//        }
//    }
    
    func parseJSON(_ weatherData: Data) ->WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            print(decodedData.name)
//            print(decodedData.main.temp)
//            print(decodedData.weather[0].description)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//            print(weather.conditionName)
//            print(weather.temperatureString)
            
            return weather
            
        } catch {
            // print(error)
            
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
