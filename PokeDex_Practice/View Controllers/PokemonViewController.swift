//
//  PokemonViewController.swift
//  PokeDex_Practice
//
//  Created by Dustin Koch on 5/14/19.
//  Copyright © 2019 Rabbit Hole Fashion. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    func updateViews(pokemon: Pokemon, spriteImage: UIImage) {
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name.uppercased()
            self.abilitiesLabel.text = pokemon.abilities[0].ability.name.uppercased()
            self.idLabel.text = String(pokemon.id)
            self.spriteImageView.image = spriteImage
        }
    }

}// END OF CLASS

extension PokemonViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonController.shared.fetchPokemon(searchTerm: searchText.lowercased()) { (pokemon) in
            guard let pokemon = pokemon else { return }
            //ADDING IMAGE AS SEPARATE COMPLETION, move update views inside completion block
            PokemonController.shared.fetchImageFor(pokemon: pokemon, completion: { (image) in
                guard let image = image else { return }
                self.updateViews(pokemon: pokemon, spriteImage: image)
            })
            
        }
    }
}
