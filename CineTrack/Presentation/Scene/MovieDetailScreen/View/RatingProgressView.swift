//
//  RatingProgressView.swift
//  CineTrack
//
//  Created by TiniT on 15/4/26.
//

import SwiftUI

struct RatingProgressView: View {
    var voteAverage: Double = 0
    var voteCount: Int = 0
    
    var body: some View {
        let fractional = modf(voteAverage).1
        let integer = Int(modf(voteAverage).0)
        
        HStack {
            ForEach(0..<integer, id: \.self) { _ in
                StarView()
            }
            
            ForEach(0..<5-integer, id: \.self) { index in
                if index == 0 {
                    StarView(fillValue: fractional)
                } else {
                    StarView(fillValue: 0)
                }
            }
            
            Text("(\(voteCount) votes)")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.cyan)
            
            Spacer()
        }
    }
}

struct StarView: View {
    var fillValue: Double = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.gray).opacity(0.3)
                
                Rectangle()
                    .fill(Color.cyan)
                    .frame(width: geometry.size.width * fillValue)
            }
        }
        .mask(
            Image(systemName: "star.fill")
                .resizable()
        )
        .aspectRatio(1, contentMode: .fit)
        .frame(width: 20, height: 20)
        .shadow(radius: 4)
    }
}
