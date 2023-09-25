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
    private let charactersButton = CustomButton(title: "CHARACTERS")
    private let locationsButton = CustomButton(title: "LOCATIONS")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Actions
    @objc
    private func charactersButtonTapped() {
        navigationController?.pushViewController(CharactersViewController(), animated: true)
    }
    
    @objc
    private func locationsButtonTapped() {
        navigationController?.pushViewController(LocationsViewController(), animated: true)
    }
}

// MARK: - Setting View
private extension MainMenuViewController {
    func setupView() {
        setupUI()
        setupSubviews()
        setupConstraints()
        setupImageView()
        setupButtonsStackView()
        setupCharactersButton()
        setupLocationsButton()
    }
}

// MARK: - Private Methods
private extension MainMenuViewController {
    func setupUI() {
        view.backgroundColor = UIColor(
            named: ConstantsColors.backgroundColor.rawValue
        )
        navigationItem.backButtonTitle = "Main menu"
        navigationController?.navigationBar.tintColor = UIColor(
            named: ConstantsColors.buttonColor.rawValue
        )
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
            locationsButton
        ].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
    }
    
    func setupCharactersButton() {
        charactersButton.addTarget(
            self,
            action: #selector(charactersButtonTapped),
            for: .touchUpInside
        )
    }
    
    func setupLocationsButton() {
        locationsButton.addTarget(
            self,
            action: #selector(locationsButtonTapped),
            for: .touchUpInside
        )
    }
    
    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

//MARK: - Layout
private extension MainMenuViewController {
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
        
        [
            charactersButton,
            locationsButton
        ].forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(60)
            }
        }
    }
}
