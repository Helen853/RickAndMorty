//
//  Launch2ViewController.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 02.11.2023.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    lazy var headerView = UIImageView(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 70, width: 312, height: 104))
    lazy var searchTextField = UITextField(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 220, width: 312, height: 56))
    lazy var filterButton = UIButton(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 290, width: 312, height: 56))
    lazy var episodesCollectionView = UICollectionView(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 360, width: 311, height: 750), collectionViewLayout: UICollectionViewLayout())
    
    var result = [Result]()
    var closure: (() -> Void)?
    
    
    override func viewDidLoad() {
        title = "Episodes"
        view.backgroundColor = .white
        super.viewDidLoad()
        getInfoForEpisodes()
        
        closure = {
            let characterView = CharacterViewController()
            self.navigationController?.pushViewController(characterView, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createHeaderView()
        createSearchTextField()
        createFilterButton()
        createEpisodesCollectionView()
        creatBarItem()
    }
    
    func createHeaderView() {
        view.addSubview(headerView)
        headerView.center.x = view.center.x
        headerView.image = UIImage(named: "RnMHeader")
    }
    
    func createSearchTextField() {
        view.addSubview(searchTextField)
        searchTextField.center.x = view.center.x
        searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Name or episode (ex.S01E01)...",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.gray.cgColor
        searchTextField.layer.cornerRadius = 8
        searchTextField.leftViewMode = .always
        searchTextField.leftView = UIImageView(image: UIImage(named: "magnifyingGlass"))
    }
    
    func createFilterButton() {
        view.addSubview(filterButton)
        let iconImage = UIImageView(frame: CGRect(x: 20, y: 15, width: 25, height: 25))
        iconImage.contentMode = .scaleAspectFit
        iconImage.image = UIImage(named: "filtersIcon")
        filterButton.addSubview(iconImage)
        filterButton.center.x = view.center.x
        filterButton.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.9490196078, blue: 0.9921568627, alpha: 1)
        filterButton.layer.cornerRadius = 8
        filterButton.setTitle("ADVANCED FILTERS", for: .normal)
        filterButton.setTitleColor(
            #colorLiteral(
                red: 0.1294117647,
                green: 0.5882352941,
                blue: 0.9529411765,
                alpha: 1
            ),
            for: .normal
        )
        
        filterButton.layer.shadowOpacity = 0.5
        filterButton.layer.shadowRadius = 2.0
        filterButton.layer.shadowColor = UIColor.gray.cgColor
        filterButton.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func createEpisodesCollectionView() {
        view.addSubview(episodesCollectionView)
        episodesCollectionView.backgroundColor = .white
        episodesCollectionView.center.x = view.center.x
        episodesCollectionView.delegate = self
        episodesCollectionView.dataSource = self
        episodesCollectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell1")
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 50
        flowLayout.minimumInteritemSpacing = 50
        episodesCollectionView.collectionViewLayout = flowLayout
    }
    
    func creatBarItem() {
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Home2"), tag: 0)
        
        self.tabBarItem = tabBarItem
    }
    
    func getInfoForEpisodes() {
        let API = "https://rickandmortyapi.com/api/episode"
        guard let apiURL = URL(string: API) else {
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: apiURL) {(data, response, error) in
            guard (error == nil) else {
                print(error as Any)
                return
            }
            
            if let response = response {
                print(response)
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                let response = try? decoder.decode(EpisodesModel.self, from: data)
                guard let response = response else { return }
                self.result = response.results
            }
        }
        task.resume()
    }
}

extension EpisodesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell1", for: indexPath) as? EpisodesCollectionViewCell
        guard let cell = cell else {
            return UICollectionViewCell()
        }
        let model = result[indexPath.section]
        cell.configCell(isFavourites: false, model: model, closure: closure)
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        result.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 311, height: 370)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
}

