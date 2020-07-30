//
//  EmojiMemoryGameChooser.swift
//  Memorize
//
//  Created by James Byrne on 27/07/2020.
//  Copyright © 2020 jamesbyrne. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameChooser: View {
    @EnvironmentObject var store: ThemeStore
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiMemoryGameView(theme: theme)
                        .navigationBarTitle(theme.name)
                    ) {
                        self.themeItem(theme)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        print(index)
                        self.store.themes.remove(at: index)
                    }
                }
            }
            .navigationBarTitle(self.store.name)
            .navigationBarItems(
                leading: Button(
                    action: { self.store.addTheme() },
                    label: { Image(systemName: "plus").imageScale(.large) }
                ),
                trailing: EditButton())
        }
    }
    
    private func themeItem(_ theme: Theme) -> some View {
        VStack(alignment: .leading) {
            Text(theme.name).font(.title)
                .foregroundColor(Color(theme.color))
            Text(theme.emojis.joined()).font(.callout).lineLimit(1)
        }
    }
}

struct EmojiMemoryGameChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameChooser()
    }
}
