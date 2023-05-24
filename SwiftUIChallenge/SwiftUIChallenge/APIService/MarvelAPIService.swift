//
//  APIService.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import Foundation
import Combine

protocol APIService {
    func fetchCharacters(nameStartsWith: String, sortedBy: String?) async  -> [Character]
}

class MarvelAPIService: APIService, ObservableObject {
    @Published var characters = [Character]()
    var cancellables = Set<AnyCancellable>()
    
    // Fetch data using Async/Await
    public func fetchCharacters(nameStartsWith: String, sortedBy: String?) async  -> [Character] {
        guard let apiURL = getApiUrlL(nameStartsWith: nameStartsWith, sortedBy: sortedBy) else {
            return []
        }
        
        let session = URLSession.shared
        do {
            let data = try await session.data(for: URLRequest(url: apiURL))
            let responseData = data.0 // data from response
            
            // Decode the JSON into list of characters
            let characterData = try JSONDecoder().decode(CharacterData.self, from: responseData)
            guard let characters = characterData.data?.results else {
                return []
            }
            
            // Results are sorted by the query
            return characters
        }  catch  {
            print("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    // Fetch data using Combine (example)
    func fetchCharacters(nameStartsWith: String, sortedBy: String?) {
        guard let apiURL = getApiUrlL(nameStartsWith: nameStartsWith, sortedBy: sortedBy) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: apiURL)
            .map { $0.data }
            .decode(type: CharacterData.self, decoder: JSONDecoder())
            .replaceError(with: CharacterData(data: .init(results: nil))) // No results
            .eraseToAnyPublisher()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] characterData in
                self?.characters = characterData.data?.results ?? []
            })
            .store(in: &cancellables)
    }
    
    private func getApiUrlL(nameStartsWith: String, sortedBy: String?) -> URL? {
        // Request the characters from the API
        guard var apiURL = MarvelAPI.characters().url else {
            return nil
        }
        
        // Add optional params as necessary
        if nameStartsWith.count > 0 {
            let nameStartsWithQueryItem = URLQueryItem(name: APIConstants.nameStartsWith, value: nameStartsWith)
            apiURL = apiURL.appending(queryItems: [nameStartsWithQueryItem])
        }
        
        if let sortedBy = sortedBy {
            let sortedByQueryItem = URLQueryItem(name: APIConstants.orderBy, value: sortedBy)
            apiURL = apiURL.appending(queryItems: [sortedByQueryItem])
        }
        
        return apiURL
    }
}
