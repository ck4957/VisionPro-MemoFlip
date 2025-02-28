//
//  MemoryCardView 2.swift
//  AVP_RE_Tour
//
//  Created by Chirag Kular on 2/27/25.
//

import SwiftUI

struct MemoryGameView: View {
    @StateObject private var game = MemoryGame()

    var body: some View {
        VStack {
            Text("MemoFlip")
                .font(.largeTitle)
                .padding()

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(game.cards) { card in
                    MemoryCardView(card: card) {
                        game.flipCard(card)
                        game.checkForMatch()
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    MemoryGameView()
}
