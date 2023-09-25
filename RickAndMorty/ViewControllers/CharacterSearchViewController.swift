//
//  CharacterSearchViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 12.07.2023.
//

import UIKit
import SnapKit

final class CharacterSearchViewController: UIViewController {
    
    var characters: [Character] = []
    
    private let searchTextField = UITextField()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}


// MARK: - Private Methods
private extension CharacterSearchViewController {
    func setupUI() {
        view.backgroundColor = UIColor(named: ConstantsColors.backgroundColor.rawValue)
        title = "Search a character"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.identifier
        )
        
        searchTextField.delegate = self
    }
    
    func setupSubviews() {
        view.addSubview(searchTextField)
        view.addSubview(tableView)
    }
    
    func setupSearchTextField() {
        searchTextField.backgroundColor = .gray
        searchTextField.font = UIFont(
            name: ConstantsFonts.arialBoldMT.rawValue,
            size: 21
        )
        searchTextField.returnKeyType = .search
        searchTextField.placeholder = "Name of character"
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
        searchTextField.smartDashesType = .no
        searchTextField.smartInsertDeleteType = .no
        searchTextField.spellCheckingType = .no
        
        searchTextField.layer.cornerRadius = 5
        searchTextField.leftView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 10,
            height: searchTextField.frame.height
        ))
        searchTextField.leftViewMode = .always
        
    }
    
    func setupTableView() {
        tableView.backgroundColor = UIColor(named: ConstantsColors.backgroundColor.rawValue)
    }
}

// MARK: - Table View Data Source
extension CharacterSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? CustomTableViewCell else { return cell }
        
        cell.configure(with: characters[indexPath.row].name ?? "Undefined")
        
        return cell
    }
}

// MARK: - Table View Delegate
extension CharacterSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = CharacterDetailViewController()
        controller.character = characters[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Text Field Delegate
extension CharacterSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let url = "\(APIAdresses.characters.rawValue)/?name=\(searchTextField.text ?? "")"
        guard let url = URL(string: url) else { return true }
        
        NetworkManager.shared.fetchData(url: url, decodeType: CharacterData.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.characters = data.results ?? []
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        return true
    }
}

// MARK: - Layout
private extension CharacterSearchViewController {
    func setupConstraints() {
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(22)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(16)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

// MARK: Setting View
private extension CharacterSearchViewController {
    func setupView() {
        setupUI()
        setupSubviews()
        setupConstraints()
        setupSearchTextField()
        setupTableView()
    }
}
