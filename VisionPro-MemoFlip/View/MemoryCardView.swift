//
//  MemoryCard.swift
//  AVP_RE_Tour
//
//  Created by Chirag Kular on 2/27/25.
//

import SwiftUI

struct MemoryCardView: View {
    let card: MemoryCard
    let onTap: () -> Void

    var body: some View {
        ZStack {
            if card.isFlipped || card.isMatched {
                Image(systemName: card.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.accentColor))
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
            }
        }
        .onTapGesture {
            if !card.isFlipped && !card.isMatched {
                onTap()
            }
        }
    }
}
