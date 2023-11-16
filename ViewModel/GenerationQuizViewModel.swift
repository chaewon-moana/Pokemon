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
    
        func fetchRandomPokemon() {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)") else {
                print("Invalid URL")
                return
            }
    
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(Pokemon.self, from: data)
                        if let imageUrlString = result.sprites.front_default, let imageUrl = URL(string: imageUrlString), let imageData = try? Data(contentsOf: imageUrl) {
                            DispatchQueue.main.async {
                                self.pokemonImage = UIImage(data: imageData)
                                self.pokemonName = result.name
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching data: \(error)")
                }
            }.resume()
        }

    
    func generateRandomID() {
        randomID = Int.random(in: 1...1017)
    }
    
}

