//
//  DetailsViewController.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 04.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailsViewController: UIViewController, NavigationBarTitleChangerDelegate {
    
    var computerId: Int?
    var computer: ComputerDetailsViewModel?
    
    let networkManager = NetworkManager()
    
    override func loadView() {
        view = ComputerDetailsView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: networkManager)
        getDetails()
        let rootView = view as! ComputerDetailsView
        rootView.navBarDelegate = self
        networkManager.delegate = self
        
    }
    
    private func getDetails() {
        if let id = computerId {
            if let cachedVersion = Cache.cacheInstance.cache.object(forKey: String(id) as NSString) {
                computer = cachedVersion
                
                let rootView = view as! ComputerDetailsView
                rootView.computer = computer
                rootView.updateInfo()
                rootView.updateLinks()
            } else {
                let semaphore = DispatchSemaphore(value: 0)
                networkManager.getDetailInfo(id: id, semaphore: semaphore)
                networkManager.getLinks(id: id)
            }
//            let semaphore = DispatchSemaphore(value: 0)
//            networkManager.getDetailInfo(id: id, semaphore: semaphore)
//            networkManager.getLinks(id: id)
        }
    }
    
    @objc func onDidReceiveData(_ notification: Notification)
    {
        let rootView = view as! ComputerDetailsView
        if let data = notification.userInfo as? [String: ComputerDetailsViewModel]
        {
            if let details = data["details"] {
                computer = details
                rootView.computer = details
                setupNavigationBar()
                rootView.updateInfo()
            }
        }
        if let data = notification.userInfo as? [String: [LinkToDevice]]
        {
            if let links = data["links"] {
                if let computerLocal = rootView.computer {
                    computerLocal.links = links
                    rootView.updateLinks()
                }
            }
            Cache.cacheInstance.cache.setObject(computer!, forKey: String(rootView.computer!.id) as NSString)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = computer?.name
        navigationController?.navigationBar.prefersLargeTitles = false
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.titleTextAttributes = [.foregroundColor: UIHelper.valueColor]
        navBar.barTintColor = UIHelper.backgroundColor
    }
    
    func updateDeviceTitle(computer: ComputerDetailsViewModel) {
        self.computer = computer
        navigationItem.title = computer.name
    }
    
}

extension DetailsViewController: AlertDelegate {
    func showAlert() {
        let alert = UIAlertController(title: "Connection problem", message: "Problems with internet connection.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

