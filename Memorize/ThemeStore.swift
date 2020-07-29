//
//  ThemeStore.swift
//  Memorize
//
//  Created by James Byrne on 28/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

class ThemeStore: ObservableObject {
    let name = "Memorize"
    
    private static let themesKey = "EmojiMemoryGameStore.ThemesKey"
    
    var themes: [Theme] {
        get {
            UserDefaults.standard.object(forKey: ThemeStore.themesKey) as? [Theme] ?? [
                Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🧙‍♀️", "🦇"], color: UIColor.systemOrange, numOfEmojis: 5),
                Theme(name: "Christmas", emojis: ["🎅", "🤶", "🎄", "🎁", "❄️", "⛄️"], color: UIColor.systemBlue, numOfEmojis: 6),
                Theme(name: "Summer", emojis: ["☀️", "🕶", "🥵", "🏖", "🏝", "⛱", "🌞", "🍉"], color: UIColor.systemYellow, numOfEmojis: 8),
                Theme(name: "Sports", emojis: ["⚽️", "🏓", "🏊‍♂️", "🎾", "🎿", "🏀", "🏂", "🏇", "🏈", "🏏", "🏑", "🏒", "🏸", "🏹", "⚾️", "⛳️", "🥍", "🥎", "⛷", "⛸", "🏎"], color: UIColor.systemGreen, numOfEmojis: 10),
                Theme(name: "Music", emojis: ["🎸", "🎧", "🎹", "🎤", "🎺", "🎻", "🎼", "🪕", "🎷", "🥁", "🎶", "🎵", "👩‍🎤", "👨‍🎤"], color: UIColor.systemRed, numOfEmojis: 10),
                Theme(name: "Flags", emojis: ["🇮🇪", "🇪🇸", "🇫🇷", "🇨🇦", "🇺🇸", "🇨🇳", "🇳🇮", "🇬🇧"], color: UIColor.systemGray, numOfEmojis: 8),
            ]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: ThemeStore.themesKey)
            objectWillChange.send()
        }
    }
}
