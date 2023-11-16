//
//  GenerationQuizViewModel.swift
//  PockmonAPI
//
//  Created by Greed on 11/17/23.
//

import SwiftUI

class GenerationQuizViewModel: ObservableObject {
    @Published var pokemonImage: UIImage?
    @Published var pokemonName: String = ""
    @Published var randomID = Int.random(in: 1...1017)
    
    func fetchRandomPokemon() async throws -> Pokemon {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)") else {
            print("URL Error")
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let pokemon = try decoder.decode(Pokemon.self, from: data)
        
        DispatchQueue.main.async {
            self.pokemonName = pokemon.name
        }
        
        if let imageURL = URL(string: pokemon.sprites.frontDefault) {
            do {
                let (imageData, _) = try await URLSession.shared.data(from: imageURL)
                DispatchQueue.main.async {
                    self.pokemonImage = UIImage(data: imageData)
                }
            } catch {
                print("Image Fetch Error: \(error)")
            }
        }
        
        return pokemon
    }
    
}

