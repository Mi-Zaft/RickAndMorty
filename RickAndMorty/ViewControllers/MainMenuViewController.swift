//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 28.06.2023.
//

import UIKit
import SnapKit

final class MainMenuViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let buttonsStackView = UIStackView()
    private let charactersButton = UIButton(type: .system)
    private let locationsButton = UIButton(type: .system)
    private let episodesButton = UIButton(type: .system)
    
    var allCharactersUrl = "https://rickandmortyapi.com/api/character"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubviews()
        setupConstraints()
        setupImageView()
        setupButtonsStackView()
        setupCharactersButton()
        setupLocationsButton()
        setupEpisodesButton()
    }
}

// MARK: - Private Methods
private extension MainMenuViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationItem.backButtonTitle = "Main menu"
        navigationController?.navigationBar.tintColor = UIColor(named: "buttonColor")
    }
    
    func setupSubviews() {
        [
            imageView,
            buttonsStackView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func setupImageView() {
        imageView.image = UIImage(named: "RickAndMorty")
        imageView.contentMode = .scaleToFill
    }
    
    func setupButtonsStackView() {
        [
            charactersButton,
            locationsButton,
            episodesButton
        ].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
    }
    
    func setupCharactersButton() {
        charactersButton.setTitle("CHARACTERS", for: .normal)
        charactersButton.tintColor = UIColor(named: "buttonColor")
        charactersButton.titleLabel?.font = UIFont(
            name: "AmericanTypewriter-Bold",
            size: 24
        )
        charactersButton.addTarget(self, action: #selector(charactersButtonTapped), for: .touchUpInside)
    }
    
    func setupLocationsButton() {
        locationsButton.setTitle("LOCATIONS", for: .normal)
        locationsButton.tintColor = UIColor(named: "buttonColor")
        locationsButton.titleLabel?.font = UIFont(
            name: "AmericanTypewriter-Bold",
            size: 24
        )
        locationsButton.addTarget(self, action: #selector(locationsButtonTapped), for: .touchUpInside)
    }
    
    func setupEpisodesButton() {
        episodesButton.setTitle("EPISODES", for: .normal)
        episodesButton.tintColor = UIColor(named: "buttonColor")
        episodesButton.titleLabel?.font = UIFont(
            name: "AmericanTypewriter-Bold",
            size: 24
        )
        episodesButton.addTarget(self, action: #selector(episodesButtonTapped), for: .touchUpInside)
    }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(45)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-45)
            make.height.equalTo(imageView.snp.width)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        charactersButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        locationsButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        
        episodesButton.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
    
    @objc
    func charactersButtonTapped() {
        navigationController?.pushViewController(CharactersViewController(), animated: true)
    }
    
    @objc
    func locationsButtonTapped() {
        showAlert(with: "Oops", message: "Locations coming soon")
    }
    
    @objc
    func episodesButtonTapped() {
        showAlert(with: "Oops", message: "Episodes coming soon")
    }
}
