//
//  DeviceTests.swift
//  RetroTechAppTests
//
//  Created by Evgeniy Uskov on 11.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import Foundation
import XCTest
import Alamofire

@testable import Retro_Tech

class ViewModelTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    // MARK: -ComputerViewModel Tests
    func testCreateViewModelWithCompanyValid() {
        let computer = createDeviceWithCompany()
        let viewModel = ComputerViewModel(computer: computer)
        
        XCTAssertEqual(viewModel.name, computer.name, "Error parameter: name")
        XCTAssertEqual(viewModel.companyName, computer.company?.name, "Error parameter: companyName")
    }
        
    func testCreateViewModelWithoutCompanyValid() {
        let computer = createDeviceWithoutCompany()
        let viewModel = ComputerViewModel(computer: computer)
        
        XCTAssertEqual(viewModel.name, computer.name, "Error parameter: name")
        XCTAssertNil(viewModel.companyName, "Error parameter: company")
    }
    //MARK: -ComputerDetailViewModel
    func testCretateDetailViewModelValid() {
        let computer = createDeviceAllFields()
        let viewModel = ComputerDetailsViewModel(computer: computer)
        
        XCTAssertEqual(viewModel.id, computer.id, "Error parameter: id")
        XCTAssertEqual(viewModel.name, computer.name, "Error parameter: name")
        XCTAssertEqual(viewModel.description, computer.description, "Error parameter: description")
        XCTAssertEqual(viewModel.imageUrl, computer.imageUrl, "Error parameter: imageUrl")
        
        XCTAssertEqual(viewModel.introduced, DateUtils.dateToLiteralString(date: computer.introduced!), "Error parameter: introduced")
        XCTAssertEqual(viewModel.discounted, DateUtils.dateToLiteralString(date: computer.discounted!), "Error parameter: discounted")
    }
    // MARK: -Other methods
    func createDeviceAllFields() -> Device {
        var device = Device(id: 1, name: "Device name", company: createCompany())
        device.description = "Description"
        device.introduced = Date()
        device.discounted = Date()
        device.imageUrl = "hhtp://google.com"
        return device
    }
    
    func createDeviceWithCompany() -> Device {
        let device = Device(id: 1, name: "Device name", company: createCompany())
        return device
    }
    
    func createDeviceWithoutCompany() -> Device {
        let device = Device(id: 1, name: "Device name")
        return device
    }
    
    func createCompany() -> Company {
        let company = Company(id: 1, name: "Company name")
        return company
    }

}

