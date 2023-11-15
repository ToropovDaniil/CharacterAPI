//
//  Models.swift
//  SpotifyAPI
//
//  Created by Торопов Даниил on 12.11.2023.
//

import Foundation

struct CharacterModel: Decodable {
    let results: [Character]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
//    let episode: [Episode]
    let url: String
    let created: String
}

struct Episode: Decodable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [Character]
    let url: String
    let created: String
}

struct Origin: Decodable {
    let name: String
    let url: String
}

struct Location: Decodable {
    let name: String
    let url: String
}
