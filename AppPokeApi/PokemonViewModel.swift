//
//  PokemonViewModel.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import Foundation
import Combine

@MainActor
class PokemonViewModel: ObservableObject {
    @Published var pokemons: [Pokemon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchRandomPokemons() async {
        isLoading = true
        errorMessage = nil
        pokemons.removeAll()
        
        // IDs entre 1 y 151 (Primera Gen)
        let randomIDs = (1...10).map { _ in Int.random(in: 1...151) }
        
        do {
            for id in randomIDs {
                let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                pokemons.append(pokemon)
            }
        } catch {
            errorMessage = "No se pudieron cargar los Pokémon: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
