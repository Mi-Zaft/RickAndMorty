//
//  LocationsViewController.swift
//  RickAndMorty
//
//  Created by Максим Евграфов on 12.07.2023.
//

import UIKit
import SnapKit

final class LocationsViewController: UITableViewController {
    
    private var locations: [Location] = []
    private var responseInfo: Info?
    
    private var currentPage = 1
    private var hasMoreData = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        fetchLocations(from: APIAdresses.locations.rawValue)
    }
}

// MARK: - Private Methods
private extension LocationsViewController {
    func setupNavigationBar() {
        title = "Locations"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        navBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: ConstantsColors.buttonColor.rawValue) ?? .black
        ]
        
        navBarAppearance.backgroundColor = UIColor(named: ConstantsColors.backgroundColor.rawValue)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarButtonTapped)
        )
        
        navigationController?.navigationBar.tintColor = UIColor(named: ConstantsColors.buttonColor.rawValue)
        
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: ConstantsColors.backgroundColor.rawValue)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc
    func searchBarButtonTapped() {
        navigationController?.pushViewController(LocationSearchViewController(), animated: true)
    }
    
    func fetchLocations(from url: String) {
        guard let url = URL(string: APIAdresses.locations.rawValue) else { return }
        NetworkManager.shared.fetchData(url: url, decodeType: LocationData.self) { [weak self] result in
            switch result {
            case .success(let data):
                self?.locations += data.results ?? []
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
extension LocationsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? CustomTableViewCell else { return cell }
        
        cell.configure(with: locations[indexPath.row].name ?? "Undefined")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = LocationDetailViewController()
        controller.location = locations[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - Scroll View Delegate
extension LocationsViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let tableViewHeight = scrollView.frame.height
        
        if offsetY > contentHeight - tableViewHeight && hasMoreData {
            
            hasMoreData = false
            guard let responseInfo = responseInfo,
                    let urlForParse = responseInfo.next else { return }
            
            fetchLocations(from: urlForParse)
        }
    }
}
