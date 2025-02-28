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
    var body: some View {
        VStack {
            MemoryGameView()
                .padding()

        }.padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
