//
//  NewsError.swift
//  NewsAppAdvanced
//
//  Created by Yaşar Duman on 17.10.2023.
//



import Foundation

// MARK: - Custom Error Enum
enum NewsError: String, Error {
    case invalidUsername        = "This username created an invalid request. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid Please try again."
    case unableToFavorite       = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites     = "You've already favorited this user."
}


enum AuthError: String, Error {
    case emailAlreadyInUse      = "The email is already in use!"
    case userNotFound           = "Account not found for the specified user. Please check and try again"
    case userDisabled           = "Your account has been disabled. Please contact support."
    case invalidEmail           = "Please enter a valid email!"
    case networkError           = "Network error. Please try again!"
    case weakPassword           = "The password must be 6 characters long or more!"
    case wrongPassword          = "Your password or email is incorrect!"
}
