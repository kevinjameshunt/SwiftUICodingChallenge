//
//  ContentView.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CharacterViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.characters) { character in
                NavigationLink(destination: CharacterDetailsScreen(character: character)) {
                    CharacterRowView(character: character)
                }
            }
            .navigationBarTitleDisplayMode(.inline)    
            .searchable(text: $viewModel.searchText)
        }
        .task {
            viewModel.characters = await viewModel.searchCharacters(nameStartsWith: "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
