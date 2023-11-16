//
//  GenerationQuizView.swift
//  PockmonAPI
//
//  Created by Greed on 11/17/23.
//

import SwiftUI

struct GenerationQuizView: View {
    @StateObject var generationQuizViewModel = GenerationQuizViewModel()
    
    var body: some View {
        VStack {
            Text(generationQuizViewModel.pokemonName)
            if let image = generationQuizViewModel.pokemonImage {
                Text("몇 세대 포켓몬일까요오옹??")
                Image(uiImage: image)
                
            } else {
                Text(generationQuizViewModel.pokemonName)
                ProgressView()
            }
            
            
        }
        .onAppear {
            Task {
                try await generationQuizViewModel.fetchRandomPokemon()
            }
        }
    }
}

