//
//  NewsError.swift
//  NewsAppAdvanced
//
//  Created by Yaşar Duman on 17.10.2023.
//



import Foundation

// MARK: - Custom Error Enum
enum NewsError: String, Error {
    case invalidUrl             = "Url Dönüştürülemedi. Please try again."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "The data received from the server was invalid Please try again."
}
