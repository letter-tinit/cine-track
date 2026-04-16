//
//  MovieDescriptionView.swift
//  CineTrack
//
//  Created by TiniT on 14/4/26.
//

import SwiftUI

struct MovieDescriptionView: View {
    let label: String
    let content: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: UIColor.lightGray))
            
            Text(content)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
        }
    }
}

#Preview(traits: .fixedLayout(width: 80, height: 50)) {
    MovieDescriptionView(
        label: "Director",
        content: "Molestie"
    )
    .background(.blue)
}
