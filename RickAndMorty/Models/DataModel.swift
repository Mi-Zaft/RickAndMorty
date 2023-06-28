//
//  Data.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import Foundation

struct DataModel: Decodable {
    let info: Info?
    let results: [Character]?
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
