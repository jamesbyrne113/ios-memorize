//
//  Theme.swift
//  Memorize
//
//  Created by James Byrne on 29/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import Foundation
import SwiftUI

class Theme: Codable, Identifiable {
    let id: UUID
    
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
    
    init(name: String, emojis: [String], color: UIColor, numOfEmojis: Int, id: UUID? = nil) {
        self.name = name
        self.emojis = emojis
        self.numOfEmojis = numOfEmojis
        self._color = ThemeColor(uiColor: color)
        self.id = id ?? UUID()
        
        if self.emojis.count == 0 {
            self.emojis = ["❓", "⚠️"]
        } else if self.emojis.count == 1 {
            self.emojis.append("❓")
        }
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
