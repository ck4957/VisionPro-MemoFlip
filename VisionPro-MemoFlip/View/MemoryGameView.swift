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
            Text("MemoFlip - Score: \(game.score)") // Display the score
                .font(.title)
                .padding()

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
                //.padding()
            }
        }
    }
}

struct CardView: View {
    let card: MemoryCard

    var body: some View {
        ZStack {
            if card.isFlipped || card.isMatched {
                Image(systemName: card.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
            } else {
                RoundedRectangle(cornerRadius: 10).fill(.gray)
                                    .frame(width: 100, height: 100)

            }
        }
        //.aspectRatio(2/3, contentMode: .fit)
    }
}

