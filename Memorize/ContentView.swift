//
//  ContentView.swift
//  Memorize
//
//  Created by James Byrne on 23/06/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        let font: Font
        if (viewModel.cards.count == 10) {
            font = Font.headline
        } else {
            font = Font.largeTitle
        }
        return HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                        self.viewModel.choose(card: card)
                }
                    .aspectRatio(0.67, contentMode: .fit)
            }
        }
            .padding()
            .foregroundColor(Color.orange)
            .font(font)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
