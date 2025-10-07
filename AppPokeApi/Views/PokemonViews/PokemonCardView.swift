//
//  PokemonCardView.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 05/10/25.
//

import SwiftUI

// Vista que muestra una tarjeta para un pokémon
struct PokemonCardView: View {
    let pokemon: Pokemon // Objeto pokémon

    var body: some View {
        ZStack {
            // Fondo con bordes redondeados y una ligera sombra
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(radius: 4)

            // Contenido principal: Imagen + Nombre
            VStack {
                // Carga la imagen del pokémon desde una URL remota
                AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                    // Si la imagen se carga correctamente, se muestra
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 80)
                } placeholder: {
                    // Mientras carga la imagen, se muestra un indicador de progreso
                    ProgressView()
                }

                // Nombre del pokémon
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 4)
            }
            .padding()
        }
        .frame(height: 140)
    }
}
