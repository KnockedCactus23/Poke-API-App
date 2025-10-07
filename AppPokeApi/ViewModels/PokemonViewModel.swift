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
    @Published var pokemons: [Pokemon] = [] // Lista de pokemones obtenidos desde la API
    @Published var isLoading = false // Indica que se está realizando la carga de datos
    @Published var errorMessage: String? // Mensaje de error

    // Función para obtener 10 pokemones aleatorios desde la API
    func fetchRandomPokemons() async {
        // Activa la carga y limpia errores o datos previos
        isLoading = true
        errorMessage = nil
        pokemons.removeAll()
        
        // Genera una lista de 10 IDs aleatorios entre 1 y 151 (Primera Gen)
        let randomIDs = (1...10).map { _ in Int.random(in: 1...151) }
        
        do {
            // Recorre los IDs aleatorios y obtiene cada pokémon desde la API
            for id in randomIDs {
                // Construye la URL de la API usando el ID del pokémon
                let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")! // Endpoint utilizado
                
                // Realiza la petición HTTP y obtiene los datos
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // Decodifica la respuesta JSON en un objeto pokémon
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                
                // Agrega el Pokémon descargado a la lista
                pokemons.append(pokemon)
            }
        } catch {
            // Si ocurre un error, se muestra un mensaje de error
            errorMessage = "Pokémons couldn't be loaded: \(error.localizedDescription)"
        }
        
        // Desactiva el indicador de carga
        isLoading = false
    }
}
