//
//  ComputerTabeViewModel.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 05.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation

class ComputerViewModel {
    let computer: Device
    
    public init(computer: Device) {
        self.computer = computer
    }
    
    public var id: Int {
        return computer.id
    }
    
    public var name: String {
        return computer.name
    }
    
    public var companyName: String? {
        guard let company = computer.company else {
            return nil
        }
        return company.name
    }
}
