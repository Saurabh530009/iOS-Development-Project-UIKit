//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var cityLabel: UILabel?
    @IBOutlet weak var searchTextField: UITextField? {
        didSet {
            searchTextField?.delegate = self
        }
    }
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        // Ask user for location access
        locationManager.requestWhenInUseAuthorization()
        //Requests the one-time delivery of the user’s current location.
        locationManager.requestLocation()
        
        // Starts the generation of updates that report the user’s current location.
        // i.e. it give continuous location of user
        //locationManager.startUpdatingLocation()
        
        weatherManager.delegate = self
        searchTextField?.delegate = self
    }
    @IBAction func locationBtnPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        // To tell the search field that we done with editing, so you can dismiss the keyboard
        searchTextField?.endEditing(true)
        
        print(searchTextField?.text ?? "0")
    }
    
    // Notify that the user have pressed return/go key on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField?.endEditing(true)
        print(searchTextField?.text ?? "0")

        return true
    }
    
    // Used for validation on the word that use typed
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if (textField.text != ""){
            return true
        }
        else{
            textField.placeholder = "Type something here"
            return false
        }
    }
    
    // Call when we stop typing in the text field
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city.
        
        if let city = searchTextField?.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField?.text = ""
    }
}


// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // print(weather.temperature)
        DispatchQueue.main.async {
            self.temperatureLabel?.text = weather.temperatureString
            self.cityLabel?.text = weather.cityName
            self.conditionImageView?.image = UIImage(systemName: weather.conditionName)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print(locations)
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            
//            print(location)
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
//            print(lat)
//            print(lon)
            
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
