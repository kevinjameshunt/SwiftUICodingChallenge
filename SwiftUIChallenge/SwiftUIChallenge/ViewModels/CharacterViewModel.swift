//
//  CharacterViewModel.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import Foundation

class CharacterViewModel: ObservableObject {
    enum Constants {
        static let sortedBy: String = "name"
    }
    
    @Published var characters: [Character] = []
    @Published var searchText: String = "" {
        didSet {
            Task {
                let characters = await self.searchCharacters(nameStartsWith: searchText)
                await MainActor.run { self.characters = characters }
            }
        }
    }
    
    @Published var apiService: MarvelAPIService

    init(apiService: MarvelAPIService = MarvelAPIService()) {
        self.apiService = apiService
    }

    func searchCharacters(nameStartsWith: String) async  -> [Character] {
        return await apiService.fetchCharacters(nameStartsWith: nameStartsWith, sortedBy: Constants.sortedBy)
    }
}
