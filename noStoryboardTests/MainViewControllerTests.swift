//
//  MainViewControllerTests.swift
//  noStoryboardTests
//
//  Created by Kevin Wang on 10/12/18.
//  Copyright © 2018 KevinWang. All rights reserved.
//

import XCTest

class MainViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let mainVC = MainViewController()
      let settingsLabel = mainVC.settingsLabel
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
