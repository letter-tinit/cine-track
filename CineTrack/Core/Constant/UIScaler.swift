//
//  UIScaler.swift
//  CineTrack
//
//  Created by TiniT on 6/4/26.
//

import UIKit

struct UIScaler {
    static let screenWidth = UIScreen.current.bounds.width
    
    static var scaledWidth: CGFloat {
        screenWidth / AppConstants.Scale.designWidth
    }
}
