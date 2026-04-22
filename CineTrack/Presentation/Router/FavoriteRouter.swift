//
//  FavoriteRouter.swift
//  CineTrack
//
//  Created by TiniT on 21/4/26.
//

import SwiftUI
import Observation

enum FavoriteRoute: Hashable {
    case movieDetail
}

@Observable
final class FavoriteRouter: AppRouter<FavoriteRoute> {}
