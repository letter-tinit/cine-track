//
//  BaseStore.swift
//  CineTrack
//
//  Created by TiniT on 14/4/26.
//

import Observation

@Observable
class BaseStore {
    var errorMessage: String? = nil
    var isLoading = false
    var isPresentedAlert: Bool = false
    
    open func primaryAlertButton() -> AlertButton? {
        nil
    }
    
    open func secondaryAlertButton() -> AlertButton? {
        nil
    }
    
    open func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            switch apiError {
            case .apiError(let message, _):
                errorMessage = message
            case .network:
                errorMessage = "No internet connection"
            case .decoding:
                errorMessage = "Data decode error. Please try again."
            default:
                errorMessage = "Something went wrong"
            }
        } else if let favoriteError = error as? FavoriteLocalDataError {
            switch favoriteError {
            case .saveFailed:
                errorMessage = "Failed to save favorite. Please try again."
            case .fetchFailed:
                errorMessage = "Failed to load favorites. Please try again."
            case .movieNotFound:
                errorMessage = "Movie not found in your favorites."
            }
        }
        else {
            errorMessage = "Unexpected error"
        }
    }
    
    open func dismissError() {
        errorMessage = nil
    }
}
