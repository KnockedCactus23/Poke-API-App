//
//  Team.swift
//  AppPokeApi
//
//  Created by Sergio Rodríguez Pérez on 04/10/25.
//

import SwiftUI

// Modelo que representa un equipo de Pokémon creado por el usuario
struct Team: Identifiable, Hashable {
    let id = UUID() // id generado automáticamente
    var name: String
    var color: Color
    var pokemons: [Pokemon] = []

    // Equatable (por id), dos equipos son iguales si tienen el mismo id
    static func == (lhs: Team, rhs: Team) -> Bool {
        lhs.id == rhs.id
    }

    // Hashable (por id)
    // Se usa el id como valor único para generar el hash del objeto
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
