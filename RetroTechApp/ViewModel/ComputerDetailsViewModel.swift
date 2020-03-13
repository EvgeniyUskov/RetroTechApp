//
//  ComputerViewModel.swift
//  RetroTechApp
//
//  Created by Evgeniy Uskov on 04.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import UIKit
import SDWebImage

class ComputerDetailsViewModel: ComputerViewModel {
    
    var links: [LinkToDevice]?
    
    public override init (computer: Device) {
        super.init(computer: computer)
    }
    
    var imageUrl: String? {
        return computer.imageUrl
    }
    
    public var description: String {
        return computer.description!
    }
    
    public var introduced: String? {
        guard let introducedDate = computer.introduced else {
            return nil
        }
        return DateUtils.dateToLiteralString(date: introducedDate)
    }
    
    public var discounted: String? {
        guard let discountedDate = computer.discounted else {
            return nil
        }
        return DateUtils.dateToLiteralString(date: discountedDate)
    }
    
}
