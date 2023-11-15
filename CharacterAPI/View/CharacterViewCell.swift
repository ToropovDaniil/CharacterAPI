//
//  CharacterViewCell.swift
//  CharacterAPI
//
//  Created by Торопов Даниил on 15.11.2023.
//

import UIKit

final class CharacterViewCell: UITableViewCell {
    
    @IBOutlet weak var imageCharacter: UIImageView!
    @IBOutlet weak var labelEpisode: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelSpecies: UILabel!
    @IBOutlet weak var labelName: UILabel!
    
    
    func configur(character: Character) {
        labelName.text = character.name
        labelSpecies.text = character.species
        labelLocation.text = character.location.name
        
        NetworkManager.shared.fetch(dataType: Character.self, url: character.url) { character in
            NetworkManager.shared.fetchImageCharacters(url: character.image) { imageData in
                self.imageCharacter.image = UIImage(data: imageData)
            }
        }
        
//Мои наработки:
        
//        NetworkManager.shared.fetch(dataType: Episode.self, url:  "https://rickandmortyapi.com/api/episode/9") { episode in
//            self.labelEpisode.text = episode.name
//        }
    }
}
        
//        if let firstEpisode = character.episode.first {
//            labelEpisode.text = firstEpisode.name
