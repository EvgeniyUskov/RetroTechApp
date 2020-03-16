//
//  NetworkManager.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 04.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class NetworkManager {
    enum RequestType {
        case devices
        case details
        case links
    }
    
    static private let webUrl = "http://testwork.nsd.naumen.ru"
    
    static private let computerListPath = "/rest/computers"
    static private let detailsPath = "/rest/computers/"
    static private let suggestedLinksSuffix = "/similar"
    
    let jsonManager = JSONManager()
    
    weak var delegate: AlertDelegate?
    
    static func getComputerListUrl() -> String {
        return NetworkManager.webUrl + NetworkManager.computerListPath
    }
    
    static func getDetailsUrl(id: Int) -> String {
        return NetworkManager.webUrl + NetworkManager.detailsPath +  String(id)
    }
    
    static func getSuggestedLinksUrl(id: Int) -> String {
        return NetworkManager.webUrl + NetworkManager.detailsPath + String(id) + NetworkManager.suggestedLinksSuffix
    }
    
    func getComputers(pageIndex: Int, searchText: String? = nil) {
        DispatchQueue.global().async {
            var parameters = [String: Any]()
            parameters["p"] = pageIndex
            if let text = searchText{
                parameters["f"] = text
            }
            Alamofire.request(NetworkManager.getComputerListUrl(), method: .get, parameters: parameters).responseJSON {
                (response) in
                if response.result.isSuccess {
                    self.getResponse(type: .devices, response: response)
                }
                else {
                    debugPrint("Error loading devices")
                    self.delegate?.showAlert()
                }
            }
        }
    }
    
    func getDetailInfo(id: Int, semaphore: DispatchSemaphore) {
        DispatchQueue.global().async {
            Alamofire.request(NetworkManager.getDetailsUrl(id: id), method: .get).responseJSON {
                (response) in
                if response.result.isSuccess {
                    self.getResponse(type: .details, response: response)
                    semaphore.signal()
                }
                else {
                    debugPrint("Error loading details for device id: \(id)")
                    self.delegate?.showAlert()
                }
            }
            let _ = semaphore.wait(timeout: .now() + 0.3)
        }
    }
    
    func getLinks(id: Int) {
        DispatchQueue.global().async {
            Alamofire.request(NetworkManager.getSuggestedLinksUrl(id: id), method: .get).responseJSON {
                (response) in
                if response.result.isSuccess {
                    self.getResponse(type: .links, response: response)
                }
                else {
                    debugPrint("Error loading links for device id: \(id)")
                    self.delegate?.showAlert()
                }
            }
        }
    }
    
    func getResponse(type: RequestType, response: DataResponse<Any>) {
        var receivedData = [String: Any]()
        switch type {
        case .devices :
            let computers = self.jsonManager.parseItemsJSON(response: response)
            receivedData["computers"] = computers
        case .details:
            let computerDetails = self.jsonManager.parseDetailsJSON(response: response)
            receivedData["details"] = computerDetails
        case .links:
            let links = self.jsonManager.parseLinksJSON(response: response)
            receivedData["links"] = links
        }
        NotificationCenter.default.post(name: .didReceiveData, object: self, userInfo: receivedData)
    }
    
}
