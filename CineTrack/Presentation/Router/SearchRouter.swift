//
//  SearchRouter.swift
//  CineTrack
//
//  Created by TiniT on 15/4/26.
//

import Observation
import SwiftUI

enum SearchRoute: Hashable {
    case movieDetail
}

@Observable
final class SearchRouter: AppRouter<SearchRoute> {
    func popToView(_ target: SearchRoute) {
        if let index = path.lastIndex(of: target) {
            path = Array(path.prefix(index + 1))
        }
    }
}
