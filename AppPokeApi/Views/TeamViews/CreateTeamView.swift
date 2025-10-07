//
//  CreateTeamView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 04/10/25.
//

import SwiftUI

// Vista para crear un equipo
struct CreateTeamView: View {
    @EnvironmentObject var store: PokemonStore
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = "" // Nombre del equipo
    @State private var color: Color = .red // Color del equipo
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo gradiente rojo
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.red.opacity(0.4),
                        Color.red.opacity(0.2),
                        Color.white
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    // Encabezado visual
                    VStack(spacing: 8) {
                        Image(systemName: "person.3.sequence.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.red.opacity(0.8))
                        Text("Create Your Pokémon Team")
                            .font(.title2.bold())
                            .foregroundColor(.red)
                    }
                    .padding(.top, 30)
                    
                    // Contenedor del formulario
                    VStack(spacing: 20) {
                        // Nombre de equipo
                        TextField("Team Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        HStack {
                            // Color del equipo
                            Text("Team Color:")
                                .font(.headline)
                            Spacer()
                            ColorPicker("", selection: $color)
                                .labelsHidden()
                        }
                        .padding(.horizontal)
                        
                        // Botón para crear el equipo
                        Button(action: {
                            guard !name.isEmpty else { return }
                            store.createTeam(name: name, color: color)
                            dismiss()
                        }) {
                            Label("Create Team", systemImage: "plus.circle.fill")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(color)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.white.opacity(0.85))
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .principal) {
                    // Botón para crear un nuevo equipo, una vez uno ha sido creado
                    Text("New Team")
                        .font(.title2.bold())
                        .foregroundColor(.red)
                }
            }
        }
    }
}
