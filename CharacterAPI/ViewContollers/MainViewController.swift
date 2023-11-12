//
//  ViewController.swift
//  SpotifyAPI
//
//  Created by Торопов Даниил  on 12.11.2023.
//


import UIKit

enum Link {
    case character
    
    var url: URL {
        switch self {
        case .character:
            return URL(string: "https://rickandmortyapi.com/api/character/248")!
        }
    }
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

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
     var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class MainViewController: UICollectionViewController {

    // MARK: - Private Methods
    private let characterActions = CharacterAction.allCases
    
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

// MARK: UICollectionViewDataSource
extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterAction", for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
        cell.characterLabel.text = characterActions[indexPath.item].title
       return cell
    }
}

// MARK: UICollectionViewDelegate
extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characterAction = characterActions[indexPath.item]

        switch characterAction {
        case .showCharacter:
            showCharacter()
        }
  }
  
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100) }
    }

// MARK: - Networking
extension MainViewController {
    private func showCharacter() {
        URLSession.shared.dataTask(with: Link.character.url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                
                DispatchQueue.main.async { [unowned self] in
                    self.showAlert(withStatus: .success)
                }
                print(character)
                
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { [unowned self] in
                    self.showAlert(withStatus: .failed)
                }
            }
        }.resume()
        
    }
}
