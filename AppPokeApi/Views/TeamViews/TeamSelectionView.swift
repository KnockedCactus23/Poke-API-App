//
//  TeamSelectionView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 04/10/25.
//

import SwiftUI

// Vista para seleccionar un equipo para un pokémon
struct TeamSelectionView: View {
    @EnvironmentObject var store: PokemonStore
    let pokemon: Pokemon // Pokémon actual
    
    @State private var showCreateTeam = false // Mostrar el botón de crear un equipo, cuando no existen equipos creados
    
    // Gradiente dinámico según el tipo de pokémon
    var gradient: LinearGradient {
        let type = pokemon.types.first?.type.name ?? "default"
        switch type {
        case "grass": return LinearGradient(colors: [.green, .mint], startPoint: .top, endPoint: .bottom)
        case "fire": return LinearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom)
        case "water": return LinearGradient(colors: [.blue, .teal], startPoint: .top, endPoint: .bottom)
        case "electric": return LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
        case "psychic": return LinearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottom)
        case "rock": return LinearGradient(colors: [.gray, .brown], startPoint: .top, endPoint: .bottom)
        case "ground": return LinearGradient(colors: [.brown, .orange], startPoint: .top, endPoint: .bottom)
        case "bug": return LinearGradient(colors: [.green, .yellow], startPoint: .top, endPoint: .bottom)
        case "ice": return LinearGradient(colors: [.cyan, .blue], startPoint: .top, endPoint: .bottom)
        case "dragon": return LinearGradient(colors: [.indigo, .orange], startPoint: .top, endPoint: .bottom)
        case "ghost": return LinearGradient(colors: [Color.purple.opacity(0.8), Color.black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
        case "poison": return LinearGradient(colors: [Color.purple, Color.green.opacity(0.7)], startPoint: .top, endPoint: .bottom)
        default: return LinearGradient(colors: [.gray, .black], startPoint: .top, endPoint: .bottom)
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo dinámico según tipo
                gradient.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Si no existen equipos, se muestra la vista para crear uno
                    if store.teams.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "person.3.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.white)
                            Text("No teams created yet")
                                .font(.headline)
                                .foregroundColor(.white)
                            Button("Create Team") {
                                showCreateTeam = true
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                    } else {
                        List {
                            // Se permite agregar pokémones a los equipos disponibles si no están al máximod de su capacidad
                            ForEach(store.teams) { team in
                                Button(action: {
                                    store.addPokemon(pokemon, to: team)
                                }) {
                                    HStack {
                                        Circle()
                                            .fill(team.color)
                                            .frame(width: 20, height: 20)
                                        Text(team.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("\(team.pokemons.count)/6")
                                            .foregroundColor(.gray)
                                            .font(.subheadline)
                                    }
                                    .padding(.vertical, 6)
                                }
                            }
                            .listRowBackground(Color.white.opacity(0.9))
                        }
                        .scrollContentBackground(.hidden)
                        #if os(iOS)
                        .listStyle(.insetGrouped)
                        #endif
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Select Team")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Team")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("New Team") {
                        showCreateTeam = true
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            #endif
            
            // Hoja para crear un nuevo equipo
            .sheet(isPresented: $showCreateTeam) {
                CreateTeamView()
                    .environmentObject(store)
            }
        }
    }
}
