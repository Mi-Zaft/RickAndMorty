//
//  APIError.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 08.07.2023.
//
import Foundation

enum Erros {
    case invalidURL
}

struct APIError: Error, Decodable {
    var message: String?
    var code: Int?
}
