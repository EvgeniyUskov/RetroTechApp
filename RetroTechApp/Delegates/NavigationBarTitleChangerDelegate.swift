//
//  NavBarTitleChangerDelegate.swift
//  NaumenTestApp
//
//  Created by Evgeniy Uskov on 10.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation

protocol NavigationBarTitleChangerDelegate: AnyObject {
    func updateDeviceTitle(computer: ComputerDetailsViewModel)
}
