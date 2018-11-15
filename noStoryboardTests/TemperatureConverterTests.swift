//
//  TemperatureConverterTests.swift
//  
//
//  Created by Kevin Wang on 10/12/18.
//

import XCTest

class TemperatureConverterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      let tempKelvin: Double = 273.15
      let tempC: Double = 0.0
      XCTAssertEqual(tempKelvin.kelvinToCelsius(), tempC)
      XCTAssertNotEqual(tempKelvin.kelvinToFarenheit(), 0.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
