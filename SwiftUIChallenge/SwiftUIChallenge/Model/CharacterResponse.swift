//
//  CharacterResponse.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import Foundation

struct CharacterData: Codable {
    let data: CharacterResults?
    
    struct CharacterResults: Codable {
        let results: [Character]?
        
        enum CodingKeys: String, CodingKey {
            case results
        }
    }
}


