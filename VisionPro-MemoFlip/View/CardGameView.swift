//
//  CardView.swift
//
//  Created by Chirag Kular on 2/27/25.
//

import SwiftUI

struct CardGameView: View {
    @StateObject private var game = CardFlipGame()

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
                        CardView(card: card)
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
