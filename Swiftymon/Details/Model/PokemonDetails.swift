//
//  PokemonDetails.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 26/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

// MARK: - PokemonDetails
struct PokemonDetails: Codable {
    let evolutionChain: EvolutionChain?
    let evolvesFromSpecies: Pokemon?
    private let flavorTextEntries: [FlavorTextEntry]?
    let id: Int
    let name: String
    
    var flavorText: String? {
        guard let currentLocale = Locale.current.identifier.components(separatedBy: "_").first, let flavors = flavorTextEntries else { return nil }
        return flavors.first { $0.language.name == currentLocale }?.flavorText
    }
    
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
        case evolvesFromSpecies = "evolves_from_species"
        case flavorTextEntries = "flavor_text_entries"
        case id, name
    }
}

// MARK: - EvolutionChain
struct EvolutionChain: Codable {
    let url: String
}

// MARK: - FlavorTextEntry
private struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Language
    
    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

private struct Language: Codable {
    let name: String
    let url: String?
}
