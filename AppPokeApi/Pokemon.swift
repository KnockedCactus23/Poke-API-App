//
//  Pokemon.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [StatElement]
}

struct Sprites: Codable {
    let front_default: String?
}

struct StatElement: Codable {
    let base_stat: Int
    let stat: Stat
}

struct Stat: Codable {
    let name: String
}
