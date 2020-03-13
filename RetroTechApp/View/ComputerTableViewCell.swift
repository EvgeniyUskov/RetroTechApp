//
//  ComputerTableViewCell.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 05.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit

class ComputerTableViewCell: UITableViewCell {
    let nameCaptionLabel: UILabel = {
        return UILabel.makeCaptionLabel(text: "Name")
    }()
    
    let nameLabel: UILabel = {
        return UILabel.makeValueLabel(text: "")
    }()
    
    let companyCaptionLabel: UILabel = {
        return UILabel.makeCaptionLabel(text: "Company")
    }()
    
    let companyLabel: UILabel = {
        return UILabel.makeValueLabel(text: "")
    }()
    
    private lazy var nameStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [nameCaptionLabel, nameLabel], spacing: CGFloat(4))
    }()
    
    private lazy var companyStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [companyCaptionLabel, companyLabel], spacing: CGFloat(4))
    }()
    
    private lazy var stackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [nameStackView, companyStackView], spacing: CGFloat(5))
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:
            reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(stackView)
        companyStackView.isHidden = true
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5)
        ])
        backgroundColor = UIHelper.backgroundColor
        accessoryType = .disclosureIndicator
    }
    
    func setupData(computer: ComputerViewModel) {
        nameLabel.text = computer.name
        if let companyName = computer.companyName {
            companyLabel.text = companyName
            showCompanyStackView()
        } else {
            hideCompanyStackView()
        }
    }
    
    func hideCompanyStackView() {
        companyStackView.isHidden = true
    }
    
    func showCompanyStackView() {
        companyStackView.isHidden = false
    }
}
