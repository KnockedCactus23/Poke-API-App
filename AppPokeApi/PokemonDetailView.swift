//
//  PokemonDetailView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                    image.resizable()
                         .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                
                Text("ID: \(pokemon.id)")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Stats")
                        .font(.headline)
                    
                    ForEach(pokemon.stats, id: \.stat.name) { stat in
                        HStack {
                            Text(stat.stat.name.capitalized)
                            Spacer()
                            Text("\(stat.base_stat)")
                        }
                    }
                }
                .padding()
                
                HStack {
                    Button("Add to Favorites") {
                        // Acción futura
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Add to Team") {
                        // Acción futura
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}
