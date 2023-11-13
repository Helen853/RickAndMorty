//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Киса Мурлыса on 09.11.2023.
//

import UIKit

class CharacterViewController: UIViewController {
    
    var circleImageView = UIImageView(frame: CGRect(x: 0, y: 184, width: 147, height: 148))
    var cameraButton = UIButton(frame: CGRect(x: 300, y: 242, width: 32, height: 32))
    var titleLabel = UILabel(frame: CGRect(x: 0, y: 379.59, width: 314.6, height: 32.39))
    var infoTableView = UITableView(frame: CGRect(x: 0, y: 460, width: 312, height: 384))
    var infoLabel = UILabel(frame: CGRect(x: 60, y: 430, width: 157, height: 24))
   
    
    var nameInfo = [
        "Gender                                           ",
        "Status                                           ",
        "Status                                           ",
        "Origin                                           ",
        "Type                                             ",
        "Location                                         "
    ]
    
    var secondoryNameInfo = [
        "Male",
        "Alive",
        "Human",
        "Earth (C-137)",
        "Unknown",
        "Earth"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCircleImage()
        createCameraButton()
        createTitleLabel()
        createInfoTable()
        createInfoLabel()
        createNavigationBar()
    }
    
    func createCircleImage() {
        circleImageView.center.x = view.center.x
        circleImageView.image = UIImage(named: "Media")
        circleImageView.clipsToBounds = true
        view.addSubview(circleImageView)
        circleImageView.layer.cornerRadius = circleImageView.frame.width / 2
        circleImageView.layer.borderWidth = 5
        circleImageView.layer.borderColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        circleImageView.contentMode = .scaleAspectFit
    }
    
    func createCameraButton() {
        view.addSubview(cameraButton)
        cameraButton.setImage(UIImage(named: "Camera"), for: .normal)
        cameraButton.addTarget(self, action: #selector(showAlert), for: .touchDown)
    }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Загрузите изображение", message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Камера", style: .default, handler: {action in
            self.tapCameraAction()
        }))
        alertController.addAction(UIAlertAction(title: "Галерея", style: .default, handler: {action in
            self.tapGalleruAction()
        }))
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func tapCameraAction() {
        let alertControllerAcessCamera = UIAlertController(
            title: "Разрешить доступ к камере?",
            message: "Это необходимо, чтобы сканировать штрихкоды, номер карты и использовать другие возможности",
            preferredStyle: .alert
        )
        
        alertControllerAcessCamera.addAction(UIAlertAction(title: "Разрешить          ", style: .default))
        alertControllerAcessCamera.addAction(UIAlertAction(title: "Отменить", style: .default))
        
        present(alertControllerAcessCamera, animated: true)
    }
    
    
    func tapGalleruAction() {
        let alertControllerAcessPhoto = UIAlertController(
            title: "Разрешить доступ к 'Фото'?",
            message: "Это необходимо для добавления ваших фотографий",
            preferredStyle: .alert
        )
        
        alertControllerAcessPhoto.addAction(UIAlertAction(title: "Разрешить          ", style: .default))
        alertControllerAcessPhoto.addAction(UIAlertAction(title: "Отменить", style: .default))
        
        present(alertControllerAcessPhoto, animated: true)
    }
    
    func createTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.center.x = view.center.x
        titleLabel.text = "Rick Sanchez"
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabel.font.withSize(32)
    }
    
    func createInfoTable() {
        view.addSubview(infoTableView)
        infoTableView.backgroundColor = .white
        infoTableView.center.x = view.center.x
        infoTableView.delegate = self
        infoTableView.dataSource = self
    }
    
    func createInfoLabel() {
        infoLabel.text = "Informations"
        view.addSubview(infoLabel)
        infoLabel.font = infoLabel.font.withSize(20)
        infoLabel.textColor = #colorLiteral(red: 0.6251093745, green: 0.6256788373, blue: 0.6430239081, alpha: 1)
    }
    
    func createNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logo-black 1"), style: .plain, target: self, action: nil)
        navigationItem.setRightBarButton(rightBarButtonItem, animated: true)
        navigationItem.setHidesBackButton(true, animated: false)
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(tapNavigationBarButton))
        navigationItem.setLeftBarButton(leftBarButtonItem, animated: false)
        leftBarButtonItem.tintColor = .black
        rightBarButtonItem.tintColor = .black
        
    }
    
    @objc func tapNavigationBarButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension CharacterViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = nameInfo[indexPath.row]
        configuration.secondaryText = secondoryNameInfo[indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

