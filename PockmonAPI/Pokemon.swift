//
//  Pokemon.swift
//  PockmonAPI
//
//  Created by cho on 2023/11/15.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [Types]
    let weight: Int
    let height: Int
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
