//
//  PokemonStore.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class PokemonStore: ObservableObject {
    @Published var favorites: [Pokemon] = [] // Lista de pokémones en favoritos
    @Published var teams: [Team] = [] // Lista de equipos creados
    
    // Manejo de Pokemones Favoritos
    func toggleFavorite(_ pokemon: Pokemon) {
        if let index = favorites.firstIndex(where: { $0.id == pokemon.id }) {
            // Si ya estaba en favoritos, lo quitamos
            favorites.remove(at: index)
        } else {
            // Si no está, lo agregamos
            favorites.append(pokemon)
        }
    }
    
    // Función para ver si un Pokémon es favorito o no
    func isFavorite(_ pokemon: Pokemon) -> Bool {
        return favorites.contains(where: { $0.id == pokemon.id })
    }
    
    // Manejo de Equipos
    func addPokemon(_ pokemon: Pokemon, to team: Team) {
        // Agrega el pokémon al equipo, si este no se encuentra en el
        guard let index = teams.firstIndex(where: { $0.id == team.id }) else { return }
        // Evita duplicados y máximo 6 pokémon
        if !teams[index].pokemons.contains(where: { $0.id == pokemon.id }) &&
            teams[index].pokemons.count < 6 {
            teams[index].pokemons.append(pokemon)
        }
    }
    
    // Función que permite remover un pokémon de un equipo
    func removePokemon(_ pokemon: Pokemon, from team: Team) {
        guard let index = teams.firstIndex(where: { $0.id == team.id }) else { return }
        teams[index].pokemons.removeAll { $0.id == pokemon.id }
    }
    
    // Función que crea un nuevo equipo con un nombre y un color
    func createTeam(name: String, color: Color) {
        let newTeam = Team(name: name, color: color)
        teams.append(newTeam)
    }
    
    // Función que comprueba si el pokémon está en algún equipo
    func isInAnyTeam(_ pokemon: Pokemon) -> Bool {
        teams.contains { team in
            team.pokemons.contains { $0.id == pokemon.id }
        }
    }
}

