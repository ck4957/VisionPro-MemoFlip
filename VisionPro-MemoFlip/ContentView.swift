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
    @EnvironmentObject var gameModel: CardFlipGame

    var body: some View {
        VStack {
            CardGameView()
                .padding()
        }.padding()
    }
}

#Preview() {
    ContentView()
        .environmentObject(CardFlipGame())
}
