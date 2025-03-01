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
            HStack {
                Text("MemoFlip - Score: \(game.score)")
                    .font(.title)
                    .padding()

                Spacer()

                Button(action: {
                    game.resetGame()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Restart").font(.title2)
                    }
                    .padding()
                }
                .padding(.trailing)
            }

            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                    ForEach(game.cards) { card in
                        MemoryCardView(card: card)
                            .onTapGesture {
                                game.flipCard(card)
                                game.checkForMatch()
                            }
                    }
                }
            }
        }
    }
}

