//
//  PokemonController.swift
//  PokeDex_Practice
//
//  Created by Dustin Koch on 5/14/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import Foundation
import UIKit


class PokemonController {
    
    //Singleton
    static let shared = PokemonController()
    
    //MARK: - CRUD
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        //Build the URL
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2") else { return }
        let pokemonComponentURL = baseURL.appendingPathComponent("pokemon")
        let finalURL = pokemonComponentURL.appendingPathComponent(searchTerm)
        //print is just a test
        print(finalURL)
        
        //Start dataTask
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do{
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(pokemon)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
            }
        }.resume()
    }//END OF FETCH POKEMON
    
    func fetchImageFor(pokemon: Pokemon, completion: @escaping (UIImage?) -> Void) {
        let baseURL = pokemon.sprites.image
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let data = data else { return }
            let image = UIImage(data: data)
            completion(image)
        }.resume()
    }//END OF IMAGE FETCH
    
}//END OF CLASS
