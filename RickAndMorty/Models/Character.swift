//
//  Character.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import Foundation

public struct Character: Decodable {
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
    
    init(characterData: [String: Any]) {
        id = characterData["id"] as? Int ?? 0
        name = characterData["name"] as? String ?? ""
        status = characterData["status"] as? String ?? ""
        species = characterData["species"] as? String ?? ""
        type = characterData["type"] as? String ?? ""
        gender = characterData["gender"] as? String ?? ""
        origin = characterData["origin"] as? Origin ?? Origin(name: "", url: "")
        location = characterData["location"] as? Location ?? Location(
            id: 0,
            name: "",
            type: "",
            dimension: "",
            residents: [],
            url: "",
            created: ""
        )
        image = characterData["image"] as? String ?? ""
        episode = characterData["episode"] as? [String] ?? []
        url = characterData["url"] as? String ?? ""
        created = characterData["created"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.map { Character(characterData: $0) }
    }
}

struct Origin: Decodable {
    let name: String?
    let url: String?
}

public struct Location: Decodable {
    let id: Int?
    let name: String?
    let type: String?
    let dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}

struct CharacterData: Decodable {
    let info: Info?
    let results: [Character]?
    
    init() {
        info = Info(count: 0, pages: 0, next: "", prev: "")
        results = []
    }
    
    init(characterData: [String: Any]) {
        info = characterData["info"] as? Info ?? Info(
            count: 0,
            pages: 0,
            next: "",
            prev: ""
        )
        results = characterData["results"] as? [Character] ?? []
    }
    
    init(info: Info, results: [Character]) {
        self.info = info
        self.results = results
    }
    
    static func getData(from value: [String: Any]) -> CharacterData {
        guard let infoData = value["info"] as? [String: Any] else { return CharacterData() }
        let info = Info(
            count: infoData["count"] as? Int ?? 0,
            pages: infoData["pages"] as? Int ?? 0,
            next: infoData["next"] as? String ?? "",
            prev: infoData["prev"] as? String ?? ""
        )
        guard let infoCharacters = value["results"] as? [[String: Any]] else { return CharacterData() }
        var characters: [Character] = []
        for infoCharacter in infoCharacters {
            let character = Character(characterData: infoCharacter)
            characters.append(character)
        }
        let characterData = CharacterData(info: info, results: characters)
        return characterData
    }
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
