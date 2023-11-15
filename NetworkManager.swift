//
//  NetworkManager.swift
//  CharacterAPI
//
//  Created by Торопов Даниил  on 14.11.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum List: String {
    case url = "https://rickandmortyapi.com/api/character"
}

enum CharacterAction: CaseIterable {
    case showCharacter
    
    var title: String {
        switch self {
        case .showCharacter:
            return "Character"
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(T) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return print(error?.localizedDescription ?? "No error description")
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(type)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchImageCharacters(url: String, completion: @escaping(Data) -> Void) {
        guard let url = URL(string: url) else { return }
        guard let imageData = try? Data(contentsOf: url) else { return }
        completion(imageData)
    }
    
    private init() {
    }
}

