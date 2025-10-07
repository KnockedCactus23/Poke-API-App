//
//  Pokemon.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import Foundation


// Modelo principal de un Pokémon obtenido desde el API
struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    let types: [PokemonType]
    let sprites: Sprites
    let stats: [StatElement]
}

// Modelo para las imagenes del Pokémon
struct Sprites: Codable {
    let front_default: String? // URL de la imagen
}

// Modelo para una estadística individual
struct StatElement: Codable {
    let base_stat: Int
    let stat: Stat
}

// Modelo para el nombre de la estadística
struct Stat: Codable {
    let name: String
}

// Modelo que representa el tipo del Pokémon
struct PokemonType: Codable, Equatable {
    let slot: Int
    let type: TypeName
}

// Modelo para el nombre del tipo del Pokémon
struct TypeName: Codable, Equatable {
    let name: String
}
