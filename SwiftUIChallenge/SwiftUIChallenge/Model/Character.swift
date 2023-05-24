//
//  Character.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import SwiftUI

struct Character: Codable, Identifiable {
    var id: Int?
    let name: String?
    let thumbnail: Thumbnail?
    let description: String?
    let comics: ComicsList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumbnail
        case description
        case comics
    }
    
    struct ComicsList: Codable {
        let items: [Comic]
        
        struct Comic: Codable {
            let name: String
        }
    }

}

