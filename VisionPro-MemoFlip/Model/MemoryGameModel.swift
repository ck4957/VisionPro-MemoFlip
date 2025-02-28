//
//  MemoryGameModel.swift
//  AVP_RE_Tour
//
//  Created by Chirag Kular on 2/27/25.
//

import AVFoundation
import Foundation

struct MemoryCard: Identifiable {
    let id = UUID()
    let imageName: String
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

class MemoryGame: ObservableObject {
    @Published var cards: [MemoryCard]
    var reps_sound_effect: AVAudioPlayer?

    init() {
        let images = ["star", "car", "bus", "cloud", "cat", "bird", "fish", "leaf",
                      "carrot", "house"] // Add nostalgic images later
        let pairedImages = images + images
        cards = pairedImages.shuffled().map { MemoryCard(imageName: $0) }
    }

    func flipCard(_ card: MemoryCard) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFlipped.toggle()
            playSound(sound: "flipcard", type: ".mp3")
        }
    }

    func checkForMatch() {
        let flippedCards = cards.filter { $0.isFlipped && !$0.isMatched }
        if flippedCards.count == 2 {
            if flippedCards[0].imageName == flippedCards[1].imageName {
                // playSound(sound: "success", type: "wav") // Play success sound
                for i in 0..<cards.count {
                    if cards[i].id == flippedCards[0].id || cards[i].id == flippedCards[1].id {
                        cards[i].isMatched = true
                    }
                }
                if cards.allSatisfy({ $0.isMatched }) {
                    playSound(sound: "success", type: ".mp3") // Play celebration sound
                }
            } else {
                playSound(sound: "error-5", type: ".mp3") // Play incorrect sound
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                for i in 0..<self.cards.count {
                    if !self.cards[i].isMatched {
                        self.cards[i].isFlipped = false
                    }
                }
            }
        }
    }

    func playSound(sound: String, type: String) {
        // Play a sound without vibration
        guard let url = Bundle.main.url(forResource: sound, withExtension: type) else { return }
        do {
            reps_sound_effect = try AVAudioPlayer(contentsOf: url)
            reps_sound_effect?.play()
        } catch {
            print("Error playing sound! \(error.localizedDescription)")
        }
    }
}
