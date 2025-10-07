//
//  HomeView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

// Vista de Home / Inicial
struct HomeView: View {
    @StateObject private var viewModel = PokemonViewModel()
    @State private var hasLoaded = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo gradiente azul
                LinearGradient(
                    gradient: Gradient(colors: [.blue.opacity(0.5), .white]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack {
                    // Se muestra un mensaje de carga mientras se obtiene respuesta de la API
                    if viewModel.isLoading {
                        ProgressView("Loading Pokémons...")
                            .padding()
                        // Se muestra un mensaje de error, si hubo problema para obtener los datos
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                            .padding()

                    } else {
                        ScrollView {
                            // Se muestran los 10 pokémones obtenidos a manera de tarjetas
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(viewModel.pokemons) { pokemon in
                                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                        PokemonCardView(pokemon: pokemon)
                                    }
                                }
                            }
                            .padding()
                        }
                    }

                    // Si no se están cargando los datos, se muestra el botón para generar nuevos pokémones aleatorios
                    if !viewModel.isLoading{
                        Button(action: {
                            // Llama a la función para obtener 10 pokémones de la API
                            Task { await viewModel.fetchRandomPokemons() }
                        }) {
                            Label("Random Pokémons", systemImage: "dice")
                                .padding()
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
            }
            
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Pokédex")
                        .font(.largeTitle.bold())
                }
            }
            .task {
                if !hasLoaded {
                    await viewModel.fetchRandomPokemons()
                    hasLoaded = true
                }
            }
        }
    }
}

 
 
