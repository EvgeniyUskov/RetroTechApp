//
//  LabelHelper.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 05.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class UIHelper {
    static let backgroundColor = UIColor("#f4f0e3")
    static let captionColor = UIColor("#608377")
    static let valueColor = UIColor("#378469")
    static let linkColor = UIColor("#843739")
    
    static let tapForMoreInfoTitle = NSLocalizedString("More info...", comment: "More info")
    static let tapForLessInfoTitle = NSLocalizedString("Less info...", comment: "Less info")
    
}

extension UILabel {
    static func makeCaptionLabel(text: String) -> UILabel {
        let label = makeLabelInternal(fontSize: 12)
        label.textColor = UIHelper.captionColor
        label.text = text
        return label
    }
    
    static func makeValueLabel(text: String) -> UILabel {
        let label = makeLabelInternal(fontSize: 17)
        label.textColor = UIHelper.valueColor
        label.text = text
        return label
    }
    
    static func makeDescriptionLabel(text: String) -> UILabel {
        let label = makeLabelInternal(fontSize: 17)
        label.text = text
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIHelper.valueColor
        return label
    }
    
    static func createURLString(text: String, url: String) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: text, attributes:[NSAttributedString.Key.link: URL(string: url)!])
    }
    
    private static func makeLabelInternal(fontSize: CGFloat) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .left
        return label
    }
    
}

extension UIButton {
    static func customButton(title: String, titleColor: UIColor, tintColor: UIColor, backgroundColor: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.backgroundColor = backgroundColor
        button.tintColor = tintColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }
}

extension UIStackView {
    static func makeVerticalStackView(views: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = spacing
        stackView.distribution = .fillProportionally
        return stackView
    }
    
    static func makeHorizontalStackView(views: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = spacing
        stackView.distribution = .fillProportionally
        return stackView
    }
    
}
