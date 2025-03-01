//
//  CardView.swift
//
//  Created by Chirag Kular on 2/27/25.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    // Function to get shape-specific color
    private func cardColor(_ imageName: String) -> Color {
        switch imageName {
        case "star":
            return .yellow
        case "car":
            return .blue
        case "bus":
            return .accentColor
        case "cloud":
            return .cyan
        case "cat":
            return .blue
        case "bird":
            return .red
        case "fish":
            return .pink
        case "leaf":
            return .green
        case "carrot":
            return .orange
        case "house":
            return .brown
        default:
            return .purple
        }
    }
    
    // Function to determine background gradient based on card image
    private func backgroundGradient(_ imageName: String) -> LinearGradient {
        let color = cardColor(imageName)
        return LinearGradient(
            gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.3)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    var body: some View {
        ZStack {
            // Card background - always visible
            RoundedRectangle(cornerRadius: 15)
                .fill(card.isMatched ? Color.gray.opacity(0.3) : Color.white.opacity(0.8))
                .frame(width: 100, height: 100)
            
            RoundedRectangle(cornerRadius: 15)
                .strokeBorder(lineWidth: card.isMatched ? 1 : 2)
                .foregroundColor(card.isMatched ? .gray : .blue)
                .frame(width: 100, height: 100)
            
            // Front of card
            if card.isFlipped || card.isMatched {
                // Card front - when flipped or matched
                ZStack {
                    // Colored background based on card type
                    RoundedRectangle(cornerRadius: 12)
                        .fill(backgroundGradient(card.imageName))
                        .frame(width: 90, height: 90)
                    
                    // Card image with stylized appearance
                    Image(systemName: card.imageName)
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .symbolRenderingMode(.hierarchical)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                }
                .opacity(card.isMatched ? 0.7 : 1.0) // Dim matched cards slightly
                .rotation3DEffect(
                    .degrees(card.isFlipped || card.isMatched ? 0 : 180),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            }
            
            // Back of card
            if !(card.isFlipped || card.isMatched) {
                ZStack {
                    // Card back - when face down
                    RoundedRectangle(cornerRadius: 12)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.blue.opacity(0.6), .purple.opacity(0.6)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 90, height: 90)
                    
                    // Card back pattern or logo
                    Image(systemName: "questionmark.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.white.opacity(0.7))
                }
                .rotation3DEffect(
                    .degrees(card.isFlipped || card.isMatched ? 180 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
            }
        }
        // Apply this animation modifier to the entire card container
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: card.isFlipped)
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0), value: card.isMatched)
    }
}

#Preview {
    CardView(card: Card(imageName: "bus", isFlipped: true, isMatched: false))
}
