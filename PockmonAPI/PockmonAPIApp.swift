//
//  PockmonAPIApp.swift
//  PockmonAPI
//
//  Created by cho on 2023/11/15.
//

import SwiftUI

let defaultSprites = Sprites(front_default: nil)
let defaultPokemon = Pokemon(id: 0, name: "", sprites: defaultSprites, weight: 0, height: 0)

@main
struct PockmonAPIApp: App {
    var body: some Scene {
        WindowGroup {
            GenerationQuizView(currentPokemon: defaultPokemon)
        }
    }
}
