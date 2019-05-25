//
//  URLBuilder.swift
//  Swiftymon
//
//  Created by Rajeev Bhatia on 25/05/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

enum URLBuilder {
    
    case pokemonSpecies
    case pokemonImage(id: String)
    case pokemonDetails(id: String)
    
    var path: String {
        
        switch self {
        case .pokemonSpecies:
            return urlString(with: UrlBase.pokemonSpecies, specifiers: [(UrlParams.offset, UrlValues.offset), (UrlParams.limit, UrlValues.limit)])
        case .pokemonImage(id: let id):
            return UrlBase.imageBase.rawValue + id + ".png"
        case .pokemonDetails(id: let id):
            return UrlBase.apiBase.rawValue + UrlBase.pokemonSpecies.rawValue + "\\\(id)"
        }
        
    }
    
    private func urlString(with endpoint: UrlBase, specifiers: [UrlSpecifier]) -> String {
        
        var urlString = "\(UrlBase.apiBase.rawValue)\(endpoint.rawValue)"
        for (index, specifier) in specifiers.enumerated() {
            
            let joiner =  index == 0 ? "?" : "&"
            urlString += "\(joiner)\(specifier.param.rawValue)=\(specifier.value.rawValue)"
            
        }
        
        return urlString
        
    }
}

typealias UrlSpecifier = (param: UrlParams, value: UrlValues)
enum ConnectionError: Error {
    case couldNotGetDetails
}
