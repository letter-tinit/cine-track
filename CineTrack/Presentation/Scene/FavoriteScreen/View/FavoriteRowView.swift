//
//  FavoriteRowView.swift
//  CineTrack
//
//  Created by TiniT on 22/4/26.
//

import SwiftUI

struct FavoriteRowView: View {
    let movie: Movie
    
    @State private var isInfoPresented: Bool = false
    let imageWidth: CGFloat = 140
    
    var body: some View {
        HStack(alignment: .center) {
            ScaledAsyncThumnailImage(url: movie.backdropURL, designWidth: imageWidth, designHeight: imageWidth/AppConstants.Ratio.backdropRatio, cornerRadius: 8)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Text("\(movie.releaseDate.dropLast(6)) - \(movie.roundedVoteAverage) ★ - \(movie.voteCount)")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white.opacity(0.4))
                
                
                Button {
                    isInfoPresented = true
                } label: {
                    Image(systemName: "info.circle")
                        .frame(width: 20, height: 20)
                }
                .buttonStyle(.glass)
                .popover(isPresented: $isInfoPresented, attachmentAnchor: .point(.trailing), arrowEdge: .leading) {
                    ScrollView {
                        Text(movie.overview)
                            .presentationCompactAdaptation(.popover)
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundStyle(.black)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

#Preview {
    FavoriteRowView(movie: .mock)
}
