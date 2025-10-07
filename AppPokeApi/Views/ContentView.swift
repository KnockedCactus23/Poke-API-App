//
//  ContentView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 02/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // Tab para moverse entre pestañas (Home, Favorites, Teams)
        TabView {
            HomeView() // Vista Inicial
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritesView() // Vista de Favoritos
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            TeamsView() // Vista de Equipos
                .tabItem {
                    Label("Teams", systemImage: "person.3.fill")
                }
        }
        
    }
}

#Preview {
    ContentView()
        .environmentObject(PokemonStore())
}
