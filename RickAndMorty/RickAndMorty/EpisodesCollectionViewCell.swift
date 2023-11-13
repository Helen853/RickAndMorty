//
//  EpisodesCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 07.11.2023.
//

import UIKit


class EpisodesCollectionViewCell: UICollectionViewCell {
    let imageEpisodes = UIImageView(frame: CGRect(x: 0, y: 0, width: 311, height: 232))
    let nameLabelView = UILabel(frame: CGRect(x: 0, y: 232, width: 311, height: 54))
    let bottomView = UIView(frame: CGRect(x: 0, y: 286, width: 311, height: 71))
    let playImege = UIImageView(frame: CGRect(x: 10, y: 18, width: 32.88, height: 34.08))
    let numberOfSeries = UILabel(frame: CGRect(x: 50, y: 24, width: 157.56, height: 22.72))
    let likeButton = UIButton(frame: CGRect(x: 250, y: 18, width: 41, height: 40))
    var closure: (()-> Void)?
    
    var isFavourites = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageEpisodes)
        contentView.addSubview(nameLabelView)
        contentView.addSubview(bottomView)
        bottomView.addSubview(playImege)
        bottomView.addSubview(numberOfSeries)
        bottomView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(isFavourites: Bool, model: Result, closure: (() -> Void)?) {
        self.closure = closure
        self.isFavourites = isFavourites
        imageEpisodes.image = UIImage(named: "Media")
    
        nameLabelView.text = model.name
        nameLabelView.backgroundColor = .white
        createBottomView(isFavourites: isFavourites, model: model)
        
        
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        contentView.layer.shadowRadius = 5
        contentView.layer.cornerRadius = 8
        
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(segueToCharacter))
        imageEpisodes.addGestureRecognizer(tapGestRecognizer)
        imageEpisodes.isUserInteractionEnabled = true
        
        updateAvatarImage(charactersURL: model.characters.randomElement() ?? "") { stringURL in
            
            DispatchQueue.global().async {
                guard
                    let url = URL(string: stringURL),
                    let data = try? Data(contentsOf: url)
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.imageEpisodes.image = UIImage(data: data)
                }
            }
        }
    }
    
    @objc func segueToCharacter() {
        closure?()
    }
    
    func createBottomView(isFavourites: Bool, model: Result) {
        bottomView.backgroundColor = #colorLiteral(red: 0.9813271165, green: 0.9813271165, blue: 0.9813271165, alpha: 1)
        playImege.image = UIImage(named: "Play")
        numberOfSeries.text = "\(model.name) | \(model.episode)"
    
        switch isFavourites {
        case true:
            likeButton.setImage(UIImage(named: "redHeart"), for: .normal)
        case false:
            likeButton.setImage(UIImage(named: "Heart"), for: .normal)
        }
        
        likeButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc func tapButton() {
        switch isFavourites {
        case false:
            isFavourites = true
            likeButton.setImage(UIImage(named: "redHeart"), for: .normal)
        case true:
            isFavourites = false
            likeButton.setImage(UIImage(named: "Heart"), for: .normal)
        }
    }
    
    func updateAvatarImage(charactersURL: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: charactersURL) else { return }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            let decodedData = try? decoder.decode(CharactersInfo.self, from: data)
            completion(decodedData?.image ?? "")
        }
        task.resume()
    }
}


