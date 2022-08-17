//
//  TableTableViewCell.swift
//  Maps
//
//  Created by Artem Serebriakov on 17.08.2022.
//

import UIKit

struct Model {
    let latitude: Double
    let longitude: Double
    let title: String
    let subTitle: String
}

class TableViewCell: UITableViewCell {

    // MARK: UI
    lazy var lable: UILabel = {
        let lable = UILabel()
        lable.text = "Place"
        lable.textAlignment = .left
        lable.adjustsFontSizeToFitWidth = true
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setConctrains()
        
        lable.numberOfLines = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConctrains() {
        
        self.addSubview(lable)

        NSLayoutConstraint.activate([
            lable.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            lable.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            lable.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            lable.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}


