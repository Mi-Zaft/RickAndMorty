//
//  CustomTableViewCell.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 08.07.2023.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    static let identifier = "CustomTableViewCell"
    
    private let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .default
        setupUI()
        setupNameLabel()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with name: String) {
        nameLabel.text = name
    }
}

// MARK: - Private Methods
private extension CustomTableViewCell {
    func setupUI() {
        backgroundColor = UIColor(named: ConstantsColors.backgroundColor.rawValue)
    }
    
    func setupSubviews() {
        contentView.addSubview(nameLabel)
    }
    
    func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(16)
            make.right.equalTo(contentView).offset(-16)
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }
    
    func setupNameLabel() {
        nameLabel.textColor = UIColor(named: ConstantsColors.customYellow.rawValue)
        nameLabel.font = UIFont(
            name: ConstantsFonts.arialBoldMT.rawValue,
            size: 21
        )
        nameLabel.highlightedTextColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.textAlignment = .center
    }
}
