//
//  ListViewController.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import UIKit

protocol PresenterToMapViewProtocol: AnyObject {
    func goToplace(place: Place)
}

class ListViewController: UIViewController {
    
    var delegate: PresenterToMapViewProtocol!

    var places: [Place] = Place.favotite
    // MARK: UI
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idCell = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setConstrains()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: idCell)

    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath) as! TableViewCell
        let place = places[indexPath.row]
        
        cell.lable.text = place.title
        return cell
    }
}

extension ListViewController {
    func setConstrains() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ListViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let point = places[indexPath.row]
        delegate.goToplace(place: point)
    }
}
