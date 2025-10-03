//
//  ContentView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 02/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            TeamView()
                .tabItem {
                    Label("Team", systemImage: "person.3.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
