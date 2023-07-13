//
//  Data.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import Foundation

struct CharacterData: Decodable {
    let info: Info?
    let results: [Character]?
}

struct LocationData: Decodable {
    let info: Info?
    let results: [Location]?
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
