//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by James Byrne on 23/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI
import Combine

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    private var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(theme)
    }
    
    private static func createMemoryGame(_ theme: Theme) -> MemoryGame<String> {
        print("json = \(String(decoding: theme.json!, as: UTF8.self))")

        return MemoryGame<String>(numberOfPairsOfCards: theme.numOfEmojis, themeName: theme.name) { pairIndex in
            return theme.emojis[pairIndex]
        }
    }
    
    private func getTheme() -> Theme? {
        theme
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeColor: Color {
        if let uiColor = getTheme()?.color {
            return Color(uiColor)
        } else {
            return Color.black
        }
    }
    
    var score: Int {
        get { model.score }
        set { model.score = newValue }
    }
    
    var themeName: String { model.themeName.capitalized }
    
    // MARK: Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func resetGame() {
        self.model = EmojiMemoryGame.createMemoryGame(theme)
    }
}


