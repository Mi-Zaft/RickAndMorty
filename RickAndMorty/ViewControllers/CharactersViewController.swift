//
//  CharactersViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 08.07.2023.
//

import UIKit

final class CharactersViewController: UITableViewController {
    
    private var characters: [Character] = []
    private var responseInfo: Info?
    
    private var urlWithCharacters = "https://rickandmortyapi.com/api/character"
    private var currentPage = 1
    private var hasMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        getCharacters(from: urlWithCharacters)
    }
}

private extension CharactersViewController {
    private func setupNavigationBar() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "buttonColor") ?? .black
        ]
        navBarAppearance.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(searchBarButtonTapped)
        )
        
        navigationController?.navigationBar.tintColor = UIColor(named: "buttonColor")
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        tableView.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc
    func searchBarButtonTapped() {
        navigationController?.pushViewController(
            CharacterSearchViewController(),
            animated: true
        )
    }
    
    func getCharacters(from url: String) {
        let allCharactersURL = url
        guard let url = URL(string: allCharactersURL) else { return }
        NetworkManager.shared.fetchData(url: url, decodeType: DataModel.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.characters += data.results ?? []
                self?.responseInfo = data.info ?? nil
                self?.tableView.reloadData()
                
                if (self?.responseInfo?.next != nil) {
                    self?.hasMoreData = true
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - Table View Data Source
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? CustomTableViewCell else { return cell }
        
        cell.configure(with: characters[indexPath.row].name ?? "Undefined")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = CharacterDetailViewController()
        controller.character = characters[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - Table View Delegate
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

// MARK: - Scroll View Delegate
extension CharactersViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.height
        
        if offsetY > contentHeight - tableViewHeight && hasMoreData {
            
            hasMoreData = false
            guard let responseInfo = responseInfo,
                    let urlForParse = responseInfo.next else { return }
            
            getCharacters(from: urlForParse)
        }
    }
}
