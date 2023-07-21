//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice( price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = Constants.apiKey
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        
        
        //Use String concatenation to add the selected currency at the end of the baseURL along with the API key.
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        // 1. Create a URL
        //Use optional binding to unwrap the URL that's created from the urlString
        if let url = URL(string: urlString) {
            
            // 2. Create a URLSession
            //Create a new URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            //Create a new data task for the URLSession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    //print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                //Format the data we got back as a string to be able to print it.
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData){
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
                
            }
            
            // 4. Start the task
            //Start task to fetch data from bitcoin average's servers.
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) ->Double? {
        
        //Create a JSONDecoder
        let decoder = JSONDecoder()
        do {
            //try to decode the data using the CoinData structure
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
//            print(lastPrice)
            return lastPrice
            
        } catch {
            
            //Catch and print any errors.
            print(error)
            return nil
        }
    }
}
