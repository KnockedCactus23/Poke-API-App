//
//  PokemonRowView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

// Vista de fila pokémones
struct PokemonRowView: View {
    let pokemon: Pokemon // Pokémon mostrado en la vista
    
    var body: some View {
        HStack {
            // Carga de la imagen
            AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                image.resizable()
                     .scaledToFit()
            } placeholder: {
                // Indicador de progreso mientras carga
                ProgressView()
            }
            .frame(width: 80, height: 80)
            
            // Nombre del pokémon
            Text(pokemon.name.capitalized)
                .font(.headline)
        }
    }
}
