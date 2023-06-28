//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    var allCharactersUrl = "https://rickandmortyapi.com/api/character"

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllCharacters()
    }
}

// MARK: - Private Methods
private extension ViewController {
    func fetchAllCharacters() {
        guard let url = URL(string: allCharactersUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let characters = try decoder.decode(DataModel.self, from: data)
                print(characters)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
