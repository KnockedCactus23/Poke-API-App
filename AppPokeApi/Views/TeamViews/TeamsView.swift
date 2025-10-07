//
//  TeamsView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 04/10/25.
//

import SwiftUI

// Vista que muestra los equipos con sus actuales pokémones
struct TeamsView: View {
    @EnvironmentObject var store: PokemonStore
    @State private var showingCreateTeam = false // hoja para crear equipos
    @State private var isEditing = false // modo edición para quitar pokémon
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo gradiente rojo
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.3),
                        Color.red.opacity(0.1),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    // Si no existen equipos creados, se muestra la vista para crear un equipo
                    if store.teams.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "person.3.sequence.fill")
                                .font(.system(size: 60))
                                .foregroundColor(.gray.opacity(0.7))
                            Text("No teams created yet.")
                                .font(.title2)
                                .foregroundColor(.gray)
                            Button(action: { showingCreateTeam = true }) {
                                Label("Create Team", systemImage: "plus.circle.fill")
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.red)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                // Contenedor del equipo
                                ForEach(store.teams) { team in
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack {
                                            Circle()
                                                .fill(team.color)
                                                .frame(width: 20, height: 20)
                                            Text(team.name)
                                                .font(.title2.bold())
                                            Spacer()
                                            // Botón para editar el equipo
                                            Button(isEditing ? "Done" : "Edit") {
                                                withAnimation {
                                                    isEditing.toggle()
                                                }
                                            }
                                            .font(.caption)
                                            .buttonStyle(.bordered)
                                            .tint(.gray)
                                        }

                                        // Grid de Pokémon del equipo
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 12) {
                                            ForEach(team.pokemons, id: \.id) { pokemon in
                                                ZStack(alignment: .topTrailing) {
                                                    VStack(spacing: 6) {
                                                        // Se muestra la imagen y nombre del pokémon
                                                        AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                                                            image
                                                                .resizable()
                                                                .scaledToFit()
                                                        } placeholder: {
                                                            ProgressView()
                                                        }
                                                        .frame(width: 80, height: 80)

                                                        Text(pokemon.name.capitalized)
                                                            .font(.caption)
                                                            .foregroundColor(.black)
                                                    }
                                                    .padding(8)
                                                    .background(Color.white.opacity(0.9))
                                                    .cornerRadius(12)
                                                    .shadow(radius: 3)

                                                    // Si se está editando el equipo, se muestra el botón para quitar pokémones del equipo
                                                    if isEditing {
                                                        Button {
                                                            store.removePokemon(pokemon, from: team)
                                                        } label: {
                                                            Image(systemName: "xmark.circle.fill")
                                                                .foregroundColor(.red)
                                                                .padding(4)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.7))
                                    .cornerRadius(16)
                                    .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                }
                            }
                            .padding()
                        }
                    }

                    // Si ya existen equipos creados, se muestra en la parte de abajo un botón para añadir nuevos equipos
                    if !store.teams.isEmpty{
                        Button(action: { showingCreateTeam = true }) {
                            Label("Add New Team", systemImage: "plus")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)
                        .padding()

                    }
                }
            }
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Teams")
                        .font(.largeTitle.bold())
                }
            }
            // Hoja para crear nuevo equipo
            .sheet(isPresented: $showingCreateTeam) {
                CreateTeamView()
                    .environmentObject(store)
            }
        }
    }
}
