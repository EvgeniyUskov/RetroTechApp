//
//  LinkToDevice.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 10.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation

struct LinkToDevice: Hashable {
     var id: Int
     var name: String
    
    public init(id: Int, name: String) {
       self.id = id
       self.name = name
    }
    
}

extension LinkToDevice: Equatable {
    static func ==(lhs: LinkToDevice, rhs: LinkToDevice) -> Bool {
        return lhs.id == rhs.id
    }
}

