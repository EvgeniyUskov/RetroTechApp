//
//  File.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 03.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation

struct Device {
    let id: Int
    let name: String
    var description: String?
    var introduced: Date?
    var discounted: Date?
    var imageUrl: String?
    var company: Company?
    
    init(id: Int,
         name: String,
         company: Company? = nil){
        self.id = id
        self.name = name
        self.company = company
    }
    
    init(id: Int,
         name: String,
         company: Company? = nil,
         description: String? = nil,
         introduced: Date? = nil,
         discounted: Date? = nil,
         imageUrl: String? = nil){
        self.id = id
        self.name = name
        self.company = company
        self.description = description
        self.introduced = introduced
        self.discounted = discounted
        self.imageUrl = imageUrl
    }
}
