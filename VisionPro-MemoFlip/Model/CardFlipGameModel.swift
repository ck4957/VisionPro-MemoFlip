//
//  CardGameModel.swift
//
//  Created by Chirag Kular on 2/27/25.
//

import AVFoundation
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let imageName: String
    var isFlipped: Bool = false
    var isMatched: Bool = false
}

class CardFlipGame: ObservableObject {
    @Published var cards: [Card]
    @Published var score: Int = 0
    var reps_sound_effect: AVAudioPlayer?
    
    // Card images stored as a single constant
    private let cardImages = ["star", "car", "bus", "cloud", "cat", "bird", "fish", "leaf",
                              "carrot", "house"]
    
    init() {
        // Initialize with generated cards
        self.cards = []
        setupNewGame()
    }
    
    // Creates a new set of cards
    private func createCards() -> [Card] {
        let pairedImages = cardImages + cardImages
        return pairedImages.shuffled().map { Card(imageName: $0) }
    }
    
    // Setup a new game
    private func setupNewGame() {
        cards = createCards()
        score = 0
    }
    
    // Public reset method
    func resetGame() {
        setupNewGame()
        playSound(sound: "flipcard", type: ".mp3")
    }
    
    func flipCard(_ card: Card) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards[index].isFlipped.toggle()
            playSound(sound: "flipcard", type: ".mp3")
        }
    }
    
    func checkForMatch() {
        let flippedCards = cards.filter { $0.isFlipped && !$0.isMatched }
        if flippedCards.count == 2 {
            handleMatchCheck(flippedCards)
        }
    }
    
    // Handle the match checking logic
    private func handleMatchCheck(_ flippedCards: [Card]) {
        let isMatch = flippedCards[0].imageName == flippedCards[1].imageName
        
        if isMatch {
            handleMatchSuccess(flippedCards)
        } else {
            playSound(sound: "error-5", type: ".mp3")
        }
        
        // Reset non-matched cards after delay
        scheduleCardReset()
    }
    
    // Handle successful match
    private func handleMatchSuccess(_ matchedCards: [Card]) {
        score += 10
        
        // Mark matching cards
        for i in 0..<cards.count {
            if cards[i].id == matchedCards[0].id || cards[i].id == matchedCards[1].id {
                cards[i].isMatched = true
            }
        }
        
        // Check if game is complete
        if cards.allSatisfy({ $0.isMatched }) {
            playSound(sound: "success", type: ".mp3") // Play celebration sound
        }
    }
    
    // Schedule card reset after delay
    private func scheduleCardReset() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for i in 0..<self.cards.count {
                if !self.cards[i].isMatched {
                    self.cards[i].isFlipped = false
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
    
    // Stop any playing sounds when app goes to background
    func pauseSounds() {
        if let player: AVAudioPlayer = reps_sound_effect, player.isPlaying {
            player.stop()
        }
    }
}
