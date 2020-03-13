//
//  Company.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 03.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation

struct Company: Hashable {
    
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Company: Equatable {
    static func ==(lhs: Company, rhs: Company) -> Bool {
        return lhs.id == rhs.id
    }
}

