//
//  HomeView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = PokemonViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Cargando Pokémons...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.pokemons) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonRowView(pokemon: pokemon)
                        }
                    }
                }
                
                Button("Random Pokemons") {
                    Task { await viewModel.fetchRandomPokemons() }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Pokédex")
            .task {
                await viewModel.fetchRandomPokemons()
            }
        }
    }
}
