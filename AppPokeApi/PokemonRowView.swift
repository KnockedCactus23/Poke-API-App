//
//  PokemonRowView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                image.resizable()
                     .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            
            Text(pokemon.name.capitalized)
                .font(.headline)
        }
    }
}
