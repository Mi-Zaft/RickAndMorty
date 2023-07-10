//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 08.07.2023.
//

import UIKit
import SnapKit

final class CharacterDetailViewController: UIViewController {
    
    var character: Character!
    
    private let avatarImageView = UIImageView()
    private let nameResponseLabel = UILabel()
    
    private let labelsStackView = UIStackView()
    private let labelsResponseStackView = UIStackView()
    private let generalStackView = UIStackView()
    
    private let genderLabel = UILabel()
    private let genderResponseLabel = UILabel()
    private let statusLabel = UILabel()
    private let statusResponseLabel = UILabel()
    private let speciesLabel = UILabel()
    private let speciesResponseLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubviews()
        setupConstraints()
        setupAvatarImageView()
        setupNameLabel()
        setupGeneralStackView()
        setupLabelsStackView()
        setupLabelsResponseStackView()
        setupLabels()
    }
}

private extension CharacterDetailViewController {
    func setupUI() {
        title = character.name
        view.backgroundColor = UIColor(named: "backgroundColor")
    }
    
    func setupSubviews() {
        [
            avatarImageView,
            nameResponseLabel,
            generalStackView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(75)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-75)
            make.height.equalTo(avatarImageView.snp.width)
        }
        
        nameResponseLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(30)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        generalStackView.snp.makeConstraints { make in
            make.top.equalTo(nameResponseLabel.snp.bottom).offset(40)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
    }
    
    func setupGeneralStackView() {
        generalStackView.addArrangedSubview(labelsStackView)
        generalStackView.addArrangedSubview(labelsResponseStackView)
    }
    
    func setupLabelsStackView() {
        [
            genderLabel,
            statusLabel,
            speciesLabel,
        ].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
    }
    
    func setupLabelsResponseStackView() {
        [
            genderResponseLabel,
            statusResponseLabel,
            speciesResponseLabel
        ].forEach {
            labelsResponseStackView.addArrangedSubview($0)
        }
        
        labelsResponseStackView.axis = .vertical
        labelsResponseStackView.spacing = 10
    }
    
    func setupLabels() {
        [
            genderLabel,
            genderResponseLabel,
            statusLabel,
            statusResponseLabel,
            speciesLabel,
            speciesResponseLabel
        ].forEach {
            $0.font = UIFont(name: "Arial-BoldMT", size: 18)
            $0.textColor = UIColor(named: "customYellow")
        }
        setupGenderLabel()
        setupGenderResponseLabel()
        setupStatusLabel()
        setupStatusResponsibleLabel()
        setupSpeciesLabel()
        setupSpeciesResponsibleLabel()
    }
    
    func setupGenderLabel() {
        genderLabel.text = "gender:"
    }
    
    func setupGenderResponseLabel() {
        genderResponseLabel.text = character.gender ?? "unknown"
    }
    
    func setupStatusLabel() {
        statusLabel.text = "status:"
    }
    
    func setupStatusResponsibleLabel() {
        statusResponseLabel.text = character.status ?? "unknown"
    }
    
    func setupSpeciesLabel() {
        speciesLabel.text = "species:"
    }
    
    func setupSpeciesResponsibleLabel() {
        speciesResponseLabel.text = character.species ?? "unknown"
    }
    
    func setupAvatarImageView() {
        NetworkManager.shared.fetchImage(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.avatarImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupNameLabel() {
        nameResponseLabel.text = character.name
        nameResponseLabel.font = UIFont(
            name: "AmericanTypewriter-Bold",
            size: 21
        )
        nameResponseLabel.textColor = UIColor(named: "buttonColor")
        nameResponseLabel.textAlignment = .center
    }
}
