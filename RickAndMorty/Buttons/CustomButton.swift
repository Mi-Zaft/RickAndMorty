//
//  CustomButton.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 24.07.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    var customTitle: String? {
        didSet {
            setTitle(customTitle, for: .normal)
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        customTitle = title
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupButton()
    }
}

private extension CustomButton {
    func setupButton() {
        self.setTitle(customTitle, for: .normal)
        self.tintColor = UIColor(named: ConstantsColors.buttonColor.rawValue)
        self.titleLabel?.font = UIFont(
            name: ConstantsFonts.americanTypewriterBold.rawValue,
            size: 24
        )
    }
}
