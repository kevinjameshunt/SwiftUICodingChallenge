//
//  Thumbnail.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import SwiftUI

struct Thumbnail: Codable {
    let path: String?
    let pathExtension: String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case pathExtension = "extension"
    }
    
    var url: URL? {
        
        guard let path = self.path, let pathExtension = self.pathExtension else {
            return nil
        }
        let urlString = path + "." + pathExtension
        return URL(string: urlString)
    }
}
