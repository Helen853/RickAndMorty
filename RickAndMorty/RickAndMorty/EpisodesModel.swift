//
//  EpisodesModel.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 10.11.2023.
//

import Foundation

// MARK: - Welcome
struct EpisodesModel: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let id: Int
    let name, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case episode, characters, url, created
    }
}
