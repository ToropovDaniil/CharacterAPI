//
//  CharactersListViewContoller.swift
//  CharacterAPI
//
//  Created by Торопов Даниил  on 15.11.2023.
//

import UIKit

final class CharactersListViewContoller: UITableViewController {
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharactersData()
    }
    
    private func fetchCharactersData() {
        NetworkManager.shared.fetchCharactersData(dataType: CharacterModel.self, url: List.url.rawValue) { result in
            switch result {
            case .success(let characterModel):
                self.characters = characterModel.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
    
    // MARK: - Table view data source
extension CharactersListViewContoller {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterViewCell else { return UITableViewCell() }
        
        let character = characters[indexPath.row]
        cell.configur(character: character)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
