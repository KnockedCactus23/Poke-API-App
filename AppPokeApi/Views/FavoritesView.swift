//
//  FavoritesView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var store: PokemonStore

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo gradiente amarillo
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.yellow.opacity(0.2),
                        Color.orange.opacity(0.1),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // Contenido principal
                // Si la lista de favoritos está vacía, se muestra que no hay pokémones favoritos hasta el momento
                if store.favorites.isEmpty {
                    VStack {
                        Image(systemName: "star.slash")
                            .font(.system(size: 50))
                            .foregroundColor(.gray.opacity(0.7))
                            .padding(.bottom, 10)

                        Text("No favorites yet!")
                            .font(.title2.bold())
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                } else {
                    // Se muestran los pokémones seleccionados como favoritos
                    List(store.favorites) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            PokemonRowView(pokemon: pokemon)
                        }
                        .listRowBackground(Color.white.opacity(0.8))
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            #if os(ios)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Favorites")
                        .font(.largeTitle.bold())
                }
            }
        }
    }
}
