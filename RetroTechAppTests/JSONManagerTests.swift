//
//  JSONManagerTests.swift
//  RetroTechAppTests
//
//  Created by Evgeniy Uskov on 11.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import XCTest
@testable import Retro_Tech

class JSONManagerTests: XCTestCase {
    
    var sut: JSONManager!
    var jsonStorage: JSONStorage!
    
    override func setUp() {
        super.setUp()
        sut = JSONManager()
        jsonStorage = JSONStorage()
    }

    override func tearDown() {
        jsonStorage = nil
        sut = nil
    }

    func testParseDeviceListValid() {
        let deviceList = sut.parseItemsJSONInternal(jsonResponse: jsonStorage.getItems())
        
        XCTAssertTrue(deviceList.count == 5, "Not all data has been parsed")
        XCTAssertEqual(deviceList[0].name, "Acorn Archimedes-1", "Error parsing parameter: name")
        XCTAssertEqual(deviceList[0].companyName, "Acorn computer", "Error parsing parameter: company.name")
        
    }
    
    func testParseDetailInfoValid() {
        let detailInfo = sut.parseDetailsJSONInternal(jsonResponse: jsonStorage.getDetails())
        
        XCTAssertEqual(detailInfo.id, 152, "Error parsing parameter: id")
        XCTAssertEqual(detailInfo.name, "Acorn Archimedes", "Error parsing parameter: name")
        XCTAssertEqual(detailInfo.companyName, "Acorn computer", "Error parsing parameter: company.name")
        XCTAssertEqual(detailInfo.description, "SMTHNG SMTHNG", "Error parsing parameter: description")
        XCTAssertEqual(detailInfo.imageUrl, "https://images-na.ssl-images-amazon.com/images/I/51d-Cedv7%2BL.jpg", "Error parsing parameter: imageUrl")
    }
    
    func testParseLinksValid() {
        let linkList = sut.parseLinksJSONInternal(jsonResponse: jsonStorage.getLinks())
        
        XCTAssertTrue(linkList.count == 5, "Not all data has been parsed")
        XCTAssertEqual(linkList[0].name, "Nintendo Entertainment System", "Error parsing parameter: name")
        XCTAssertEqual(linkList[0].id, 151, "Error parsing parameter: name")
        
    }
}

