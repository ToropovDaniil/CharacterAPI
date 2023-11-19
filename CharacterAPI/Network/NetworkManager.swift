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
    
    func fetchCharactersData<T: Decodable>(dataType: T.Type, url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else { return
            completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let type = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImageCharacters(url: String, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        
        guard let url = URL(string: url) else { return
            completion(.failure(.invalidURL))
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    private init() {
    }
}

