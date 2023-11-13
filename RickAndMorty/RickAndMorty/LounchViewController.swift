//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 02.11.2023.
//

import UIKit

class LounchViewController: UIViewController {
    
    lazy var headerImageView = UIImageView(frame: CGRect(x: 0, y: view.safeAreaInsets.top + 100, width: 312, height: 104))
    var appNameImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupImageViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rotate(view: appNameImageView)
    }
    
    func addSubviews() {
        view.addSubview(headerImageView)
        view.addSubview(appNameImageView)
    }
    
    func setupImageViews() {
        headerImageView.center.x = view.center.x
        appNameImageView.center = view.center
        
        headerImageView.image = UIImage(named: "RnMHeader")
        appNameImageView.image = UIImage(named: "GreenCircle")
    }
    
    func rotate(view: UIView) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: 5)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = 3
        view.layer.add(rotation, forKey: "rotationAnimation")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.goToNextScreen()
        }
    }
    
    func goToNextScreen() {
        let episodesViewController = EpisodesViewController()
        let favoritesViewController = FavoritesViewController()

        let tabbarView = UITabBarController()
        tabbarView.tabBar.backgroundColor = .white
        tabbarView.setViewControllers([episodesViewController, favoritesViewController], animated: true)
        navigationController?.pushViewController(tabbarView, animated: true)
        
    }
}

