//
//  ViewController.swift
//  SpotifyAPI
//
//  Created by Торопов Даниил  on 12.11.2023.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Private Methods
    private let characterActions = CharacterAction.allCases
}

// MARK: UICollectionViewDataSource
extension MainViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characterActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterAction", for: indexPath) as? CharacterActionCell else { return UICollectionViewCell() }
        cell.characterLabel.text = characterActions[indexPath.item].title
       return cell
    }
}

// MARK: UICollectionViewDelegate
extension MainViewController {  
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100) }
    }

