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
        //        labelEpisode.text = character.episode
        
        NetworkManager.shared.fetchImageCharacters(url: character.image) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.imageCharacter.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

