//
//  ViewController.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 03.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var computerTableView: UITableView!
    
    let networkManager = NetworkManager()
    
    var computers = [ComputerViewModel]()
    
    var pageIndex: Int = 0
    var selectedComputerId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            SVProgressHUD.setBackgroundColor(UIHelper.captionColor)
            SVProgressHUD.setForegroundColor(UIHelper.backgroundColor)
            SVProgressHUD.setRingThickness(6)
            SVProgressHUD.show(withStatus: "Loading")
        }
        computerTableView.delegate = self
        computerTableView.dataSource = self
        searchBar.delegate = self
        networkManager.delegate = self
        
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: networkManager)
        networkManager.getComputers(pageIndex: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    // MARK: - Setup UI
    private func setupTableView() {
        view.backgroundColor = UIHelper.backgroundColor
        computerTableView.register(ComputerTableViewCell.self, forCellReuseIdentifier: "ComputerTableViewCell")
        computerTableView.allowsMultipleSelection = false
        computerTableView.backgroundView = UIImageView(image: UIImage(named: "background"));
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Computers"
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.tintColor = UIHelper.valueColor
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIHelper.valueColor]
        navBar.prefersLargeTitles = true
    }
    
    private func setupSearchBar() {
        searchBar.barTintColor = UIHelper.backgroundColor
        searchBar.tintColor = UIHelper.linkColor
        searchBar.searchTextField.textColor = UIHelper.valueColor
    }
    
    // MARK: - ViewController logic
    @objc func onDidReceiveData(_ notification: Notification)
    {
        if let data = notification.userInfo as? [String: [ComputerViewModel]]
        {
            if let computerList = data["computers"] {
                for computer in computerList
                {
                    computers.append(computer)
                }
                computerTableView.reloadData()
            }
        }
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Loading")
            }
            let detailsController = segue.destination as! DetailsViewController
            detailsController.computerId = selectedComputerId
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToDetails" {
            guard let _ = selectedComputerId else {
                return false
            }
            return true
        }
        return false
    }
}

// MARK: - TableViewDelegate, TableViewDataSource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComputerTableViewCell", for: indexPath) as! ComputerTableViewCell
        
        cell.setupData(computer: computers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row == computers.count - 5 { // load items a lil bit earlier
            fetchData(row: row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedComputerId = computers[indexPath.row].id
        performSegue(withIdentifier: "goToDetails", sender: self)
        computerTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func fetchData(row: Int) {
        pageIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.networkManager.getComputers(pageIndex: self.pageIndex)
        }
    }
    
}

// MARK: - Search bar methods
extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            
            SVProgressHUD.show(withStatus: "Loading")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: networkManager)
        computers.removeAll()
        networkManager.getComputers(pageIndex: 0, searchText: searchBar.text)
        computerTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            computers.removeAll()
            networkManager.getComputers(pageIndex: 0)
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

extension ViewController: AlertDelegate {
    func showAlert() {
        let alert = UIAlertController(title: "Connection problem", message: "Problems with internet connection.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        self.present(alert, animated: true)    }
    
    
}
