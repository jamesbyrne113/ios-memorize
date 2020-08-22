//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by James Byrne on 23/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI
import Combine

class EmojiMemoryGame: ObservableObject, Identifiable {
    @Published private var model: MemoryGame<String>
    
    @Published private(set) var theme: Theme

//    private(set) var _theme: CurrentValueSubject<Theme, Never>
    
//    var theme: Theme { _theme.value }
    
    let id: UUID

    private var autosaveCancellable: AnyCancellable?
    
    init(theme: Theme) {
        self.id = UUID()
        let defaultsKey = "EmojiMemoryGame.\(self.id.uuidString)"
        self.model = EmojiMemoryGame.createMemoryGame(theme)
//        self._theme = CurrentValueSubject<Theme, Never>(theme)
//        self.autosaveCancellable = self._theme.sink { theme in

        self.theme = theme
        self.autosaveCancellable = self.$theme.sink { theme in
            print("testing")
            UserDefaults.standard.set(theme.json, forKey: defaultsKey)
        }
    }
    
    init(id: UUID? = nil) {
        self.id = id ?? UUID()
        let defaultsKey = "EmojiMemoryGame.\(self.id.uuidString)"
        let theme = Theme(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? Theme()
        self.model = EmojiMemoryGame.createMemoryGame(theme)
        
        //        self._theme = CurrentValueSubject<Theme, Never>(theme)
        //        self.autosaveCancellable = self._theme.sink { theme in

        self.theme = theme
        self.autosaveCancellable = self.$theme.sink { theme in
            print("test: \(String(decoding: theme.json!, as: UTF8.self))")
            UserDefaults.standard.set(theme.json, forKey: defaultsKey)
        }
    }
    
    private static func getPlayableEmojis(theme: Theme) -> [String] {
        switch(theme.emojis.count) {
        case 0:
            return ["❓", "⚠️"]
        case 1:
            if theme.emojis[0] == "❓" {
                return ["⚠️", theme.emojis[0]]
            } else {
                return ["❓", theme.emojis[0]]
            }
        default:
            return theme.emojis
        }
    }
    
    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        print("json = \(String(decoding: theme.json!, as: UTF8.self))")
        
        let emojis = EmojiMemoryGame.getPlayableEmojis(theme: theme)

        return MemoryGame<String>(numberOfPairsOfCards: theme.numOfEmojis) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeColor: Color {
        return Color(theme.color)
    }
    
    var score: Int {
        get { model.score }
        set { model.score = newValue }
    }
    
    var themeName: String { theme.name.capitalized }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        self.model = EmojiMemoryGame.createMemoryGame(theme)
    }
}


