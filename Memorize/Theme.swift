//
//  Theme.swift
//  Memorize
//
//  Created by James Byrne on 29/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import Foundation
import SwiftUI

class Theme {
    let name: String
    var emojis: [String]
    let color: Color
    
    var numOfEmojis: Int?
    
    func getNumOfEmojis() -> Int {
        if let numOfEmojis = self.numOfEmojis {
            return numOfEmojis
        } else {
            return Int.random(in: 2...(emojis.count))
        }
    }
    
    init(name: String, emojis: [String], color: Color, numOfEmojis: Int? = nil) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numOfEmojis = numOfEmojis
    }
}
