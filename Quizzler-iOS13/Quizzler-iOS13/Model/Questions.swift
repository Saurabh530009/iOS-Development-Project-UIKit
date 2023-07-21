//
//  Questions.swift
//  Quizzler-iOS13
//
//  Created by Saurabh Kumar Verma on 05/07/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct Question {
    var text : String
    var answer : String
    init(q : String, a : String){
        self.text = q
        self.answer = a
    }
}
