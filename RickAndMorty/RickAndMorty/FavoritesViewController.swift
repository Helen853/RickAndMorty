//
//  FavoritesViewController.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 08.11.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoritesLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 228, height: 28))
    var favouriitesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 200, width: 312, height: 700), collectionViewLayout: UICollectionViewLayout())
    
    var closure: (() -> Void)?
    
    override func viewDidLoad() {
        title = "Favorites"
        super.viewDidLoad()
        view.backgroundColor = .white
        createFavorites()
        createBarItem()
        
        closure = {
            let characterView = CharacterViewController()
            self.navigationController?.pushViewController(characterView, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createFavouretisCollectionView()
    }
    
    func createFavorites() {
        view.addSubview(favoritesLabel)
        favoritesLabel.text = "Favourites Episodes"
        favoritesLabel.center.x = view.center.x
        favoritesLabel.textAlignment = .center
        favoritesLabel.font = favoritesLabel.font.withSize(24)
    }
    
    func createFavouretisCollectionView() {
        view.addSubview(favouriitesCollectionView)
        favouriitesCollectionView.backgroundColor = .white
        favouriitesCollectionView.center.x = view.center.x
        favouriitesCollectionView.delegate = self
        favouriitesCollectionView.dataSource = self
        favouriitesCollectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell1")
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 50
        favouriitesCollectionView.collectionViewLayout = layout
    }
    
    func createBarItem() {
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Vector"), tag: 0)
        self.tabBarItem = tabBarItem
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? EpisodesCollectionViewCell
        guard let cell = cell else {
            return UICollectionViewCell()
        }
        cell.configCell(isFavourites: true, model: Result(id: 1, name: "Pilot", episode: "S01E02", characters: [], url: "", created: ""), closure: closure)
       
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 311, height: 370)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
}

