//
//  CharacterDetailsScreen.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import SwiftUI

struct CharacterDetailsScreen: View {
    let character: Character

    var body: some View {
        VStack(alignment: .center) {
            CharacterRowView(character: character)
            
            Text(character.description ?? "")
                .padding()
            
            if let comics = character.comics {
                List(comics.items, id: \.name) { comic in
                    Text(comic.name)
                }
            }
            Spacer()
        }
    }
}

struct CharacterDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsScreen(character: Character(name: nil, thumbnail: nil, description: nil, comics: nil))
    }
}
