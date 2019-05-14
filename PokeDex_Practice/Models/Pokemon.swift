//
//  Pokemon.swift
//  PokeDex_Practice
//
//  Created by Dustin Koch on 5/14/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let abilities: [AbilityDictionary]
    let sprites: SpritesDictionary
}

struct AbilityDictionary: Decodable {
    let ability: Ability
    struct Ability: Decodable {
        let name: String
    }
}

struct SpritesDictionary: Decodable {
    let image: URL
    
    private enum CodingKeys: String, CodingKey {
        case image = "front_shiny"
    }
}
