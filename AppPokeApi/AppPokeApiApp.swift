//
//  AppPokeApiApp.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 02/10/25.
//

import SwiftUI

@main
struct AppPokeApiApp: App {
    
    @StateObject var store = PokemonStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
