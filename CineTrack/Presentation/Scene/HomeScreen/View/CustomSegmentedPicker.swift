//
//  CustomSegmentedPicker.swift
//  CineTrack
//
//  Created by TiniT on 8/4/26.
//

import SwiftUI

protocol SegmentItem: Hashable, CaseIterable {
    var title: String { get }
}

struct CustomSegmentedPicker<Option: SegmentItem>: View {
    @Binding var selection: Option
    
    var body: some View {
        let designHSWidth: CGFloat = CGFloat(70 * Option.allCases.count)
        let designHSHeight: CGFloat = 30.0
        HStack(spacing: 0) {
            ForEach(Array(Option.allCases.enumerated()), id: \.element) { index, option in
                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        guard selection != option else { return }
                        selection = option
                    }
                } label: {
                    let isFirst = index == 0
                    let isLast = index == Option.allCases.count - 1
                    let isInside = !isFirst && !isLast
                    let isSelected = selection == option
                    Text(option.title)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .lineLimit(1)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(isSelected ? Color.green.opacity(0.4) : Color.clear)
                                .padding(.vertical, 4)
                                .padding(isFirst ? .leading : .trailing, isInside ? 0 : 4)
                        )
                        .foregroundStyle(.white)
                        .fontWeight(isSelected ? .semibold : .regular)
                }
            }
        }
        .frame(width: designHSWidth.scaledWidth)
        .frame(height: designHSWidth.scaledWidth * designHSHeight / designHSWidth)
        .padding(4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.4))
                .padding(4)
        )
        .shadow(color: .cyan, radius: 2)
    }
}

#Preview {
    CustomSegmentedPicker(selection: .constant(TimePeriod.day))
}
