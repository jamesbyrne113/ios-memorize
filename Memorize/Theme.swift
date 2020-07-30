//
//  Theme.swift
//  Memorize
//
//  Created by James Byrne on 29/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI
import Combine

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
    
    init?(id: UUID) {
        let defaultsKey = "Theme.\(id.uuidString)"
        let json = UserDefaults.standard.data(forKey: defaultsKey)
        if json != nil, let newTheme = try? JSONDecoder().decode(Theme.self, from: json!) {
            self.id = newTheme.id
            self.name = newTheme.name
            self.emojis = newTheme.emojis
            self.numOfEmojis = newTheme.numOfEmojis
            self._color = newTheme._color
        } else {
            return nil
        }
    }
    
    init() {
        self.id = UUID()
        self.name = "Untitled"
        self.emojis = ["❓", "⚠️"]
        self.numOfEmojis = 2
        self._color = ThemeColor(uiColor: .black)
    }
    
//    init?(json: Data?) {
//        if json != nil, let newTheme = try? JSONDecoder().decode(Theme.self, from: json!) {
//            self.id = newTheme.id
//            self.name = newTheme.name
//            self.emojis = newTheme.emojis
//            self.numOfEmojis = newTheme.numOfEmojis
//            self._color = newTheme._color
//        } else {
//            return nil
//        }
//    }
    
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
