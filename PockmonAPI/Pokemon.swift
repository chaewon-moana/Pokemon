//
//  Pokemon.swift
//  PockmonAPI
//
//  Created by cho on 2023/11/15.
//

import Foundation

//struct Pokemon: Codable {
//    let name: String
//    let pokemonId: Int
//    let sprites: Sprites
//}
//
//struct Sprites: Codable {
//    let front_default: String?
//}

struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let weight: Int
    let height: Int
    
    init(id: Int, name: String, sprites: Sprites, weight: Int, height: Int) {
        self.id = id
        self.name = name
        self.sprites = sprites
        self.weight = weight
        self.height = height
    }
}

struct PokemonType: Identifiable, Hashable {
    let id = UUID()
    let name: String
}


struct Sprites: Codable {
    let front_default: String?
}

struct Types: Codable {
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}
