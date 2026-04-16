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
        } else {
            errorMessage = "Unexpected error"
        }
    }
    
    open func dismissError() {
        errorMessage = nil
    }
}
