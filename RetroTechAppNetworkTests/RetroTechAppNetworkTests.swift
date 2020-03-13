//
//  NaumenTestSlowTests.swift
//  NaumenTestSlowTests
//
//  Created by Evgeniy Uskov on 12.03.2020.
//  Copyright © 2020 Evgeniy Uskov. All rights reserved.
//

import XCTest
@testable import Retro_Tech

class RetroTechAppNetworkTests: XCTestCase {

    var sut: URLSession!
    var networkManager: NetworkManager!
    var id: Int = 151
    var pageIndex: Int = 0

    override func setUp() {
      super.setUp()
        sut = URLSession(configuration: .default)
        networkManager = NetworkManager()
    }

    override func tearDown() {
      sut = nil
      networkManager = nil
      super.tearDown()
    }

    // MARK: -Tests
    func testItemsURLIsAccessible() {
      let url =
        URL(string: NetworkManager.getComputerListUrl())
      let promise = expectation(description: "Completeion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 10)

      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    func testDetailsURLIsAccessible() {
      let url =
        URL(string: NetworkManager.getDetailsUrl(id: id) )
      let promise = expectation(description: "Completeion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 10)

      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
    func testLinksURLIsAccessible() {
      let url =
        URL(string: NetworkManager.getSuggestedLinksUrl(id: id) )
      let promise = expectation(description: "Completeion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 10)

      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
}
