//
//  ThemeStore.swift
//  Memorize
//
//  Created by James Byrne on 28/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI
import Combine

class ThemeStore: ObservableObject {
    let name: String
    
    private static let themesKey = "EmojiMemoryGameStore.ThemesKey"
    
    private var autosave: AnyCancellable?
    
    init(named name: String = "Memorize") {
        self.name = name
        let defaultsKey = "ThemeStore.\(name)"
        themes = Array(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey)) ?? []
        autosave = $themes.sink { themes in
            print("AUTOSAVED")
            UserDefaults.standard.set(themes.asPropertyList, forKey: defaultsKey)
        }
        
        if themes.count == 0 {
            themes.append(contentsOf: [
                Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🧙‍♀️", "🦇"], color: UIColor.systemOrange, numOfEmojis: 5),
                Theme(name: "Christmas", emojis: ["🎅", "🤶", "🎄", "🎁", "❄️", "⛄️"], color: UIColor.systemBlue, numOfEmojis: 6),
                Theme(name: "Summer", emojis: ["☀️", "🕶", "🥵", "🏖", "🏝", "⛱", "🌞", "🍉"], color: UIColor.systemYellow, numOfEmojis: 8),
                Theme(name: "Sports", emojis: ["⚽️", "🏓", "🏊‍♂️", "🎾", "🎿", "🏀", "🏂", "🏇", "🏈", "🏏", "🏑", "🏒", "🏸", "🏹", "⚾️", "⛳️", "🥍", "🥎", "⛷", "⛸", "🏎"], color: UIColor.systemGreen, numOfEmojis: 10),
                Theme(name: "Music", emojis: ["🎸", "🎧", "🎹", "🎤", "🎺", "🎻", "🎼", "🪕", "🎷", "🥁", "🎶", "🎵", "👩‍🎤", "👨‍🎤"], color: UIColor.systemRed, numOfEmojis: 10),
                Theme(name: "Flags", emojis: ["🇮🇪", "🇪🇸", "🇫🇷", "🇨🇦", "🇺🇸", "🇨🇳", "🇳🇮", "🇬🇧"], color: UIColor.systemGray, numOfEmojis: 8),
            ])
        }
    }
    
    @Published var themes: [Theme]
    
    func addTheme() {
        themes.append(Theme())
    }
    
    func removeTheme(_ theme: Theme) -> Bool {
        if let themeIndex = themes.firstIndex(matching: theme) {
            themes.remove(at: themeIndex)
            return true
        }
        return false
    }
}

extension Array where Element == Theme {
    var asPropertyList: [String] {
        var uuidStrings = [String]()
        for theme in self {
            uuidStrings.append(theme.id.uuidString)
        }
        return uuidStrings
    }
    
    init?(fromPropertyList plist: Any?) {
        self.init()
        let uuidStrings = plist as? [String] ?? [String]()
        for uuidString in uuidStrings {
            if let uuid = UUID(uuidString: uuidString) {
                if let theme = Theme(id: uuid) {
                    self.append(theme)
                }
            }
        }
    }
}
