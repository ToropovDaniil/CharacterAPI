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
        NetworkManager.shared.fetch(dataType: Episode.self, url: character.url) { episode in
            self.labelEpisode.text = episode.name
        }
        }
    }
        
//        if let firstEpisode = character.episode.first {
//            labelEpisode.text = firstEpisode.name
