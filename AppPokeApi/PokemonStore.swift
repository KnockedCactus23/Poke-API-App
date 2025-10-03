//
//  PokemonStore.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import Foundation
import Combine

@MainActor
class PokemonStore: ObservableObject {
    @Published var favorites: [Pokemon] = []
    
    func toggleFavorite(_ pokemon: Pokemon) {
        if let index = favorites.firstIndex(where: { $0.id == pokemon.id }) {
            // Si ya estaba en favoritos → lo quitamos
            favorites.remove(at: index)
        } else {
            // Si no está → lo agregamos
            favorites.append(pokemon)
        }
    }
    
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        return favorites.contains(where: { $0.id == pokemon.id })
    }
}
