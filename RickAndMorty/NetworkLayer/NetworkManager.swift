//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 08.07.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    
    func fetchData<T: Decodable>(
        url: URL,
        decodeType: T.Type,
        completion: @escaping(Result<T, APIError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(APIError(
                        message: error?.localizedDescription,
                        code: (error as? NSError)?.code
                    )))
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let genericModel = try decoder.decode(decodeType.self, from: data)
                    completion(.success(genericModel))
                } catch let error {
                    completion(.failure(APIError(
                        message: error.localizedDescription
                    )))
                }
            }
        }.resume()
    }
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, APIError>) -> Void) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(APIError(message: "Invalid URL")))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(APIError(message: "No Image")))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
