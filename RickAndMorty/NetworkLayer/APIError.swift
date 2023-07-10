//
//  APIError.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 08.07.2023.
//

enum erros {
    case invalidURL
}

import Foundation

struct APIError: Error, Decodable {
    var message: String?
    var code: Int?
}
