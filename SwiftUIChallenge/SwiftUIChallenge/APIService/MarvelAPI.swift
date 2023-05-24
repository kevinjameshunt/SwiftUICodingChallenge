//
//  MarvelAPI.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import Foundation

/*
 https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0
 */

enum APIConstants {
    static let useCombine = false
    static let host = "https://gateway.marvel.com"
    static let basePath = "/v1/public/"
    static let orderBy = "orderBy"
    static let nameStartsWith = "nameStartsWith"
    
    fileprivate static let privateKey = ""
    fileprivate static let publicKey = ""
}

enum MarvelAPI {
    case characters(ts: String = UUID().uuidString)
    
    var url: URL? {
        switch self {
        case .characters:
            var components = URLComponents(string: self.host)
            components?.queryItems = self.queryItems
            components?.path = self.path
            return components?.url
        }
    }
    
    var host: String {
        return APIConstants.host
    }
    
    var path: String {
        switch self {
        case .characters:
            return APIConstants.basePath + "characters"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            case .characters(let ts):
            return [
                URLQueryItem(name: "ts", value: ts),
                URLQueryItem(name: "apikey", value: APIConstants.publicKey),
                URLQueryItem(name: "hash", value: (ts + APIConstants.privateKey + APIConstants.publicKey).md5)
            ]
        }
    }
    
    

}
