//
//  HomeSectionView.swift
//  CineTrack
//
//  Created by TiniT on 7/4/26.
//

import SwiftUI

struct HomeSectionView<Content: View, Item: Identifiable>: View {
    let title: String
    let items: [Item]
    var selectionPeriod: Binding<TimePeriod>? = nil
    
    let content: (Item) -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .headingStyle()
                
                Spacer()
                
                if let selection = selectionPeriod {
                    CustomSegmentedPicker(selection: selection)
                }
                
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(items) { item in
                        content(item)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    HomeSectionView(
        title: "TITLE",
        items: Movie.mocks
    ) { show in
        MovieView(
            movie: show,
            itemType: .largeItem,
            cornerRadius: 16
        )
    }
}
