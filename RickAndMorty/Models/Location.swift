//
//  Location.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import Foundation

public struct Location: Decodable {
    let id: Int?
    let name: String?
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}
