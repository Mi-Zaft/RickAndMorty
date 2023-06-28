//
//  Character.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import Foundation

struct Character: Decodable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var origin: Origin?
    var location: Location?
    var image: String?
    var episode: [String]?
    var url: String?
    var created: String?
}

struct Origin: Decodable {
    let name: String?
    let url: String?
}
