//
//  CoinData.swift
//  ByteCoin
//
//  Created by Saurabh Kumar Verma on 10/07/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
