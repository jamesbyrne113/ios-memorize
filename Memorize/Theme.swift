//
//  Theme.swift
//  Memorize
//
//  Created by James Byrne on 29/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import Foundation
import SwiftUI

class Theme: Codable {
    let name: String
    var emojis: [String]
    fileprivate var _color: ThemeColor
    var color: UIColor {
        get { _color.uiColor }
        set { _color = ThemeColor(uiColor: newValue)}
    }
    var numOfEmojis: Int
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init(name: String, emojis: [String], color: UIColor, numOfEmojis: Int) {
        self.name = name
        self.emojis = emojis
        self.numOfEmojis = numOfEmojis
        self._color = ThemeColor(uiColor: color)
    }
    
    fileprivate struct ThemeColor: Codable {
        var red: CGFloat = -1
        var blue: CGFloat = -1
        var green: CGFloat = -1
        var alpha: CGFloat = -1
        
        init(uiColor: UIColor) {
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        
        var uiColor: UIColor {
            UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}
