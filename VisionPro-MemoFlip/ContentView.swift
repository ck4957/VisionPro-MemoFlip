//
//  ContentView.swift
//  VisionPro-MemoFlip
//
//  Created by Chirag Kular on 2/27/25.
//

import RealityKit
import RealityKitContent
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameModel: MemoryGame

    var body: some View {
        VStack {
            MemoryGameView()
                .padding()
        }.padding()
    }
}

#Preview() {
    ContentView()
        .environmentObject(MemoryGame())
}
