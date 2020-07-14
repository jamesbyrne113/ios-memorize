//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by James Byrne on 23/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()

    private static var themes = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷", "🧙‍♀️", "🦇"], color: Color.orange, numOfEmojis: 5),
        Theme(name: "Christmas", emojis: ["🎅", "🎄", "🎁", "❄️", "⛄️"], color: Color.blue),
        Theme(name: "Summer", emojis: ["☀️", "🕶", "🥵", "🏖", "🏝"], color: Color.yellow),
        Theme(name: "Sports", emojis: ["⚽️", "🏓", "🏉", "🏊‍♂️"], color: Color.green),
        Theme(name: "Music", emojis: ["🎸", "🎧", "🎹", "🎤"], color: Color.red),
        Theme(name: "Flags", emojis: ["🇮🇪", "🇪🇸", "🇫🇷", "🇨🇦", "🇺🇸", "🇨🇳", "🇳🇮", "🇬🇧"], color: Color.gray, numOfEmojis: 6),
    ]
        
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = themes.randomElement()!
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.getNumOfEmojis(), themeName: theme.name) { pairIndex in
            return theme.emojis[pairIndex]
        }
    }
    
    private func getTheme() -> Theme? {
        EmojiMemoryGame.themes.first(where: { $0.name == model.themeName })
    }
    
    // MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var themeColor: Color {
        if let color = getTheme()?.color {
            return color
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
        model = EmojiMemoryGame.createMemoryGame()
    }
}


