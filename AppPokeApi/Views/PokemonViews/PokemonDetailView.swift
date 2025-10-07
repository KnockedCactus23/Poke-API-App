//
//  PokemonDetailView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 03/10/25.
//

import SwiftUI

// Vista detallada de un pokemon
struct PokemonDetailView: View {
    let pokemon: Pokemon // Pokémon mostrado en la vista
    @EnvironmentObject var store: PokemonStore // Estado global de la app
    @State private var showAddToTeam = false // Controla si se muestra o no la hoja para agregar un equipo
    
    // Gradiente dinámico según el tipo de pokémon
    var gradient: LinearGradient {
        // Toma el tipo del pokémon, si no tiene uno, utiliza default
        let type = pokemon.types.first?.type.name ?? "default"
        
        // Devuelve un gradiente según el tipo
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
        ZStack {
            gradient.ignoresSafeArea() // Fondo con el gradiente según el tipo
            
            VStack(spacing: 16) {
                Spacer()
                
                // Imagen del pokémon
                AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 240, height: 240)
                        .shadow(radius: 12)
                } placeholder: {
                    // Indicador de progreso mientras carga
                    ProgressView()
                }
                
                // Nombre del pokémon
                Text(pokemon.name.capitalized)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                // Tipos del pokémon
                Text(pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", "))
                    .font(.title3.bold())
                    .foregroundColor(.white.opacity(0.8))
                
                // Peso y altura
                HStack(spacing: 30) {
                    VStack {
                        Text("Weight")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Text("\(Double(pokemon.weight) / 10, specifier: "%.1f") kg")
                            .foregroundColor(.white)
                    }
                    VStack {
                        Text("Height")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                        Text("\(Double(pokemon.height) / 10, specifier: "%.1f") m")
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                
                // Stats (HP, Attack, Defense, Speed)
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(["hp", "attack", "defense", "speed"], id: \.self) { statName in
                        
                        // Busca la estadística en el arreglo del Pokémon
                        if let stat = pokemon.stats.first(where: { $0.stat.name == statName }) {
                            HStack {
                                // Nombre de la estadística
                                Text(stat.stat.name.capitalized)
                                    .font(.caption)
                                    .frame(width: 60, alignment: .leading)
                                    .foregroundColor(.white.opacity(0.9))
                                
                                // Barra de nivel de la stat según su valor
                                GeometryReader { geometry in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white.opacity(0.2))
                                            .frame(height: 8)
                                        RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white)
                                            .frame(width: min(CGFloat(stat.base_stat) / 200 * geometry.size.width, geometry.size.width), height: 8)
                                    }
                                }
                                .frame(height: 8)
                                
                                // Valor numérico del stat
                                Text("\(stat.base_stat)")
                                    .font(.caption2)
                                    .foregroundColor(.white.opacity(0.9))
                                    .frame(width: 30)
                            }
                        }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                
                // Botones
                HStack(spacing: 16) {
                    // Botón para agregar o quitar de favoritos
                    Button {
                        store.toggleFavorite(pokemon)
                    } label: {
                        Image(systemName: store.isFavorite(pokemon) ? "star.fill" : "star")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                    
                    // Botón para agregar a un equipo
                    Button {
                        showAddToTeam = true
                    } label: {
                        Image(systemName: store.isInAnyTeam(pokemon) ? "person.3.fill" : "person.3")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white.opacity(0.2))
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 5)
                
                Spacer()
            }
            .padding()
        }
        // Muestra una hoja para seleccionar un equipo para agregar al pokémon
        .sheet(isPresented: $showAddToTeam) {
            TeamSelectionView(pokemon: pokemon)
                .environmentObject(store)
        }
    }
}
