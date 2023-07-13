//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 13.07.2023.
//

import UIKit
import SnapKit

final class LocationDetailViewController: UIViewController {
    
    var location: Location!
    
    private let nameResponseLabel = UILabel()
    
    private let labelsStackView = UIStackView()
    private let labelsResponseStackView = UIStackView()
    private let generalStackView = UIStackView()
    
    private let typeLabel = UILabel()
    private let typeResponseLabel = UILabel()
    private let dimensionLabel = UILabel()
    private let dimensionResponseLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubviews()
        setupConstraints()
        setupNameLabel()
        setupGeneralStackView()
        setupLabelsStackView()
        setupLabelsResponseStackView()
        setupLabels()
    }
}

private extension LocationDetailViewController {
    func setupUI() {
        title = location.name
        view.backgroundColor = UIColor(named: ConstantsColors.backgroundColor.rawValue)
    }
    
    func setupSubviews() {
        [

            nameResponseLabel,
            generalStackView
        ].forEach {
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        
        nameResponseLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
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
            typeLabel,
            dimensionLabel
        ].forEach {
            labelsStackView.addArrangedSubview($0)
        }
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 10
    }
    
    func setupLabelsResponseStackView() {
        [
            typeResponseLabel,
            dimensionResponseLabel
        ].forEach {
            labelsResponseStackView.addArrangedSubview($0)
        }
        
        labelsResponseStackView.axis = .vertical
        labelsResponseStackView.spacing = 10
    }
    
    func setupLabels() {
        [
            typeLabel,
            typeResponseLabel,
            dimensionLabel,
            dimensionResponseLabel
        ].forEach {
            $0.font = UIFont(name: ConstantsFonts.ArialBoldMT.rawValue, size: 18)
            $0.textColor = UIColor(named: ConstantsColors.customYellow.rawValue)
        }
        setupTypeLabel()
        setupTypeResponseLabel()
        setupDimensionLabel()
        setupDimensionResponsibleLabel()
    }
    
    func setupTypeLabel() {
        typeLabel.text = "type:"
    }
    
    func setupTypeResponseLabel() {
        typeResponseLabel.text = location.type ?? "unknown"
        typeResponseLabel.textAlignment = .right
    }
    
    func setupDimensionLabel() {
        dimensionLabel.text = "dimension:"
    }
    
    func setupDimensionResponsibleLabel() {
        dimensionResponseLabel.text = location.dimension ?? "unknown"
        dimensionResponseLabel.textAlignment = .right
    }
    
    func setupNameLabel() {
        nameResponseLabel.text = location.name
        nameResponseLabel.font = UIFont(
            name: ConstantsFonts.AmericanTypewriterBold.rawValue,
            size: 21
        )
        nameResponseLabel.textColor = UIColor(named: ConstantsColors.buttonColor.rawValue)
        nameResponseLabel.textAlignment = .center
    }
}

