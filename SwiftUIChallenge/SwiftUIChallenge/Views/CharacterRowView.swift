//
//  CharacterRowView.swift
//  SwiftUIChallenge
//
//  Created by Kevin Hunt on 2023-05-17.
//

import SwiftUI

struct CharacterRowView: View {
    enum Constants {
        static let thumbWidthHeight: CGFloat = 100.0
    }
    
    let character: Character
    
    var body: some View {
        HStack() {
            AsyncImage(url: character.thumbnail?.url) { phase in
                if let image = phase.image {
                    image.resizable().frame(width: Constants.thumbWidthHeight, height: Constants.thumbWidthHeight)
                } else if phase.error != nil {
                    // Indicates an error.
                    Color.red.frame(width: Constants.thumbWidthHeight, height: Constants.thumbWidthHeight)
                } else {
                    // Acts as a placeholder.
                    Color.clear.frame(width: Constants.thumbWidthHeight, height: Constants.thumbWidthHeight)
                }
            }
            Text(character.name ?? "")
            Spacer()
        }
        .padding()
    }
}

struct CharacterRowView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRowView(character: Character(name: nil, thumbnail: nil, description: nil, comics: nil))
    }
}
