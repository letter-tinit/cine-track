//
//  CGFloat+Extention.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import Foundation

extension CGFloat {
    var scaledWidth: CGFloat {
        CGFloat(self) * UIScaler.scaledWidth
    }
}
