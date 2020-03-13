//
//  JSONManager.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 04.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct JSONManager {
    func parseItemsJSON(response: DataResponse<Any>) -> [ComputerViewModel]{
        
        let jsonResponse: JSON = JSON(response.result.value!)
        
        return parseItemsJSONInternal(jsonResponse: jsonResponse)
    }
    
    func parseDetailsJSON(response: DataResponse<Any>) -> ComputerDetailsViewModel {
        let jsonResponse: JSON = JSON(response.result.value!)
        
        return parseDetailsJSONInternal(jsonResponse: jsonResponse)
    }
    
    func parseItemsJSONInternal(jsonResponse: JSON) -> [ComputerViewModel] {
        var items = [Device]()
        var viewModels = [ComputerViewModel]()
        
        let computersJSON = jsonResponse["items"]
        var newItem : Device?
        for computerJSON in computersJSON.arrayValue {
            if let companyId = computerJSON["company"]["id"].int {
                let company = Company(id: companyId,
                                      name: computerJSON["company"]["name"].stringValue)
                newItem = Device(id: computerJSON["id"].intValue,
                                 name: computerJSON["name"].stringValue,
                                 company: company)
            } else {
                newItem = Device(id: computerJSON["id"].intValue,
                                 name: computerJSON["name"].stringValue)
            }
            viewModels.append(ComputerViewModel(computer: newItem!))
            items.append(newItem!)
        }
        
        return viewModels
    }
    
    
    
    func parseDetailsJSONInternal(jsonResponse: JSON) -> ComputerDetailsViewModel {
        let computerJSON = jsonResponse
        var computer: Device?
        var viewModel: ComputerDetailsViewModel
        if computerJSON["company"]["id"].intValue != 0 {
            let company = Company(id: computerJSON["company"]["id"].intValue,
                                  name: computerJSON["company"]["name"].stringValue)
            computer = Device(id: computerJSON["id"].intValue,
                              name: computerJSON["name"].stringValue,
                              company: company,
                              description: computerJSON["description"].stringValue,
                              introduced: DateUtils.stringToDateTime(dateString: computerJSON["introduced"].stringValue),
                              discounted: DateUtils.stringToDateTime(dateString: computerJSON["discounted"].stringValue),
                              imageUrl: computerJSON["imageUrl"].stringValue)
            viewModel = ComputerDetailsViewModel(computer: computer!)
        }
        else {
            computer = Device(id: computerJSON["id"].intValue,
                              name: computerJSON["name"].stringValue,
                              description: computerJSON["description"].stringValue,
                              introduced: DateUtils.stringToDateTime(dateString: computerJSON["introduced"].stringValue),
                              discounted: DateUtils.stringToDateTime(dateString: computerJSON["discounted"].stringValue),
                              imageUrl: computerJSON["imageUrl"].stringValue)
            viewModel = ComputerDetailsViewModel(computer: computer!)
        }
        return viewModel
    }
    
    func parseLinksJSON(response: DataResponse<Any>) -> [LinkToDevice] {
        let jsonResponse: JSON = JSON(response.result.value!)
        
        return parseLinksJSONInternal(jsonResponse: jsonResponse)
    }
    
    func parseLinksJSONInternal(jsonResponse: JSON) -> [LinkToDevice]{
        var viewModels = [LinkToDevice]()
        
        for linkJSON in jsonResponse.arrayValue {
            let newItem = LinkToDevice(id: linkJSON["id"].intValue,
                                       name: linkJSON["name"].stringValue)
            viewModels.append(newItem)
        }
        return viewModels
    }
    
}
