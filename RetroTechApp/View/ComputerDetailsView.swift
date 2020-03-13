//
//  ComputerDetailsView.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 05.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD
import Alamofire

@IBDesignable
class ComputerDetailsView: UIView {
    
    let  spacing: CGFloat = 10
    let  margin: CGFloat = 10
    var isLabelExpanded: Bool = false
    
    var computer: ComputerDetailsViewModel?
    
    let networkManager = NetworkManager()
    
    weak var navBarDelegate: NavigationBarTitleChangerDelegate?
    
    private lazy var backgroundView: UIView = {
        let  view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK:- Image
    private lazy var computerImageView: UIImageView = {
        let  view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    //MARK:- Company
    private lazy var companyCaptionLabel: UILabel = {
        return UILabel.makeCaptionLabel(text: "Company")
    }()
    private lazy var companyValueLabel: UILabel = {
        return UILabel.makeValueLabel(text: "")
    }()
    private lazy var companySectionStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [companyCaptionLabel, companyValueLabel], spacing: spacing)
    }()
    //MARK:- Introduced
    private lazy var introducedDateCaptionLabel: UILabel = {
        return UILabel.makeCaptionLabel(text: "Introduced date")
    }()
    private lazy var introducedDateValueLabel: UILabel = {
        return UILabel.makeValueLabel(text: "")
    }()
    private lazy var introducedDateSectionStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [introducedDateCaptionLabel, introducedDateValueLabel], spacing: spacing)
    }()
    //MARK:- Discounted
    private lazy var discountedDateCaptionLabel: UILabel = {
        return UILabel.makeCaptionLabel(text: "Discounted date")
    }()
    private lazy var discountedDateValueLabel: UILabel = {
        return UILabel.makeValueLabel(text: "")
    }()
    private lazy var discountedDateSectionStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [discountedDateCaptionLabel, discountedDateValueLabel], spacing: spacing)
    }()
    //MARK:- Description
    private lazy var descriptionCaptionLabel: UILabel = {
        return UILabel.makeCaptionLabel(text: "Description")
    }()
    private lazy var descriptionValueLabel: UILabel = {
        return UILabel.makeDescriptionLabel(text:"No info")
    }()
    private lazy var spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.alpha = 0
        view.setContentHuggingPriority(.defaultLow - 1, for: .horizontal)
        view.setContentCompressionResistancePriority(.defaultLow - 1, for: .horizontal)
        return view
    }()
    private lazy var tapforMoreInfoButton: UIButton = {
        let  button = UIButton.customButton(title: UIHelper.tapForMoreInfoTitle, titleColor: UIHelper.captionColor, tintColor: .black, backgroundColor: UIHelper.backgroundColor)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateLabel), for: .touchUpInside)
        return button
    }()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView.makeHorizontalStackView(views: [spacerView, tapforMoreInfoButton], spacing: spacing)
        stackView.distribution = .fill
        return stackView
    }()
    private lazy var descriptionSectionStackView: UIStackView = {
        let stackView = UIStackView.makeVerticalStackView(views: [descriptionCaptionLabel, descriptionValueLabel, buttonStackView], spacing: spacing)
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: margin, bottom: 0, trailing: margin)
        stackView.alignment = .fill
        return stackView
    }()
    //MARK:- Links
    private lazy var  linksCaptionLabel: UILabel = {
        let label = UILabel.makeCaptionLabel(text: "Devices you might look at: ")
        label.textAlignment = .center
        return label
    }()
    private lazy var button1: UIButton = {
        let button = UIButton.customButton(title: "tap1", titleColor: UIHelper.linkColor, tintColor: .black, backgroundColor: UIHelper.backgroundColor)
        button.tag = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadViewData), for: .touchUpInside)
        return button
    }()
    private lazy var button2: UIButton = {
        let button = UIButton.customButton(title: "tap2", titleColor: UIHelper.linkColor, tintColor: .black, backgroundColor: UIHelper.backgroundColor)
        button.tag = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadViewData), for: .touchUpInside)
        return button
    }()
    private lazy var button3: UIButton = {
        let button = UIButton.customButton(title: "tap3", titleColor: UIHelper.linkColor, tintColor: .black, backgroundColor: UIHelper.backgroundColor)
        button.tag = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadViewData), for: .touchUpInside)
        return button
    }()
    private lazy var button4: UIButton = {
        let button = UIButton.customButton(title: "tap4", titleColor: UIHelper.linkColor, tintColor: .black, backgroundColor: UIHelper.backgroundColor)
        button.tag = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadViewData), for: .touchUpInside)
        return button
    }()
    private lazy var button5: UIButton = {
        let button = UIButton.customButton(title: "tap5", titleColor: UIHelper.linkColor, tintColor: .black, backgroundColor: UIHelper.backgroundColor)
        button.tag = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadViewData), for: .touchUpInside)
        return button
    }()
    private lazy var linksStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [button1, button2, button3, button4, button5], spacing: spacing)
    }()
    private lazy var linksSectionStackView: UIStackView = {
        return UIStackView.makeVerticalStackView(views: [linksCaptionLabel, linksStackView], spacing: spacing)
    }()
    //MARK:- InfoStackView
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView.makeVerticalStackView(views: [companySectionStackView,
                                                                  introducedDateSectionStackView,
                                                                  discountedDateSectionStackView,
                                                                  descriptionSectionStackView,
                                                                  linksSectionStackView], spacing: spacing)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    //MARK:- GlobalStackView
    private lazy var globalStackView: UIStackView = {
        let stackView = UIStackView.makeVerticalStackView(views: [computerImageView,
                                                                  infoStackView], spacing: spacing)
        stackView.distribution = .fill
        return stackView
    }()
    //MARK:- ScrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(globalStackView)
        return scrollView
    }()
    //MARK:- Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    //MARK:- Initial setup UIView
    private func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: networkManager)
        self.backgroundColor = UIHelper.backgroundColor
        addSubview(scrollView)
        
        let guide = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            computerImageView.widthAnchor.constraint(equalTo: globalStackView.widthAnchor),
            computerImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 350),
            
            descriptionValueLabel.leadingAnchor.constraint(equalTo: descriptionSectionStackView.leadingAnchor),
            descriptionSectionStackView.trailingAnchor.constraint(equalTo: descriptionValueLabel.trailingAnchor),
            
            descriptionValueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            globalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            globalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo:globalStackView.trailingAnchor),
            globalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo:globalStackView.bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            guide.trailingAnchor.constraint(equalTo:scrollView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            guide.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor, constant: 10),
            
            scrollView.widthAnchor.constraint(equalTo: guide.widthAnchor)
        ])
    }
    
    
    //MARK:- Reload data metods
    @objc func reloadViewData(sender:UIButton) {
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: "Loading")
        }
        getDetails(tag: sender.tag)
        
    }
    
    private func getDetails(tag: Int) {
        if let computerLocal = computer {
            if computerLocal.links != nil {
                let idLocal = computerLocal.links![tag - 1].id
                let semaphore = DispatchSemaphore(value: 0)
                networkManager.getDetailInfo(id: idLocal,semaphore: semaphore)
                networkManager.getLinks(id: idLocal)
            }
        }
    }
    
    @objc func onDidReceiveData(_ notification: Notification) {
        if let data = notification.userInfo as? [String: ComputerDetailsViewModel]
        {
            if let details = data["details"] {
                if details.id != computer!.id {
                    computer = details
                    navBarDelegate?.updateDeviceTitle(computer: computer!)
                    updateInfo()
                }
            }
        }
        if let data = notification.userInfo as? [String: [LinkToDevice]]
        {
            if let links = data["links"] {
                if let computerLocal = computer {
                    computerLocal.links = links
                    updateLinks()
                }
            }
        }
        
    }
    
    //MARK:- Update View methods
    func updateInfo() {
        if let device =  computer {
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Loading")
            }
            
            if let url = device.imageUrl {
                computerImageView.sd_setImage(with: URL(string: url))
                computerImageView.isHidden = false
            } else {
                computerImageView.isHidden = true
            }
            
            if let companyName = device.companyName {
                companySectionStackView.isHidden = false
                companyValueLabel.text = companyName
            } else {
                companySectionStackView.isHidden = true
            }
            
            if let introduced = device.introduced {
                introducedDateSectionStackView.isHidden = false
                introducedDateValueLabel.text = introduced
            } else {
                introducedDateSectionStackView.isHidden = true
            }
            
            if let discounted = device.discounted {
                discountedDateSectionStackView.isHidden = false
                discountedDateValueLabel.text = discounted
            } else {
                discountedDateSectionStackView.isHidden = true
            }
            
            descriptionValueLabel.text = device.description
        }
    }
    
    func updateLinks () {
        if let device = computer {
            for view in linksStackView.subviews {
                view.isHidden = true
            }
            let linksCount = device.links?.count ?? 0
            if linksCount == 0 {
                linksSectionStackView.isHidden = true
            } else {
                linksSectionStackView.isHidden = false
                for i in 0 ..< linksCount {
                    let button = linksStackView.subviews[i] as! UIButton
                    let link = device.links![i]
                    button.setTitle(link.name, for: .normal)
                    button.isHidden = false
                }
                if linksCount < 5 {
                    for i in linksCount ..< 5 {
                        linksStackView.subviews[i].isHidden = true
                    }
                }
            }
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
    }
    
    //MARK:- Update Label height
    @objc private func updateLabel() {
        if !self.isLabelExpanded {
            self.isLabelExpanded = true
            self.descriptionValueLabel.numberOfLines = 0
            tapforMoreInfoButton.setTitle(UIHelper.tapForLessInfoTitle, for: .normal)
        } else {
            self.isLabelExpanded = false
            self.descriptionValueLabel.numberOfLines = 3
            tapforMoreInfoButton.setTitle(UIHelper.tapForMoreInfoTitle, for: .normal)
        }
        
    }
    
}
