//
//  SteppedProgressBarTests.swift
//  SteppedProgressBarTests
//
//  Created by Don on 1/30/20.
//  Copyright © 2020 Don. All rights reserved.
//

import XCTest
@testable import SteppedProgressBar

class SteppedProgressBarTests: XCTestCase {

	var progressBar: SteppedProgressBar!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		progressBar = SteppedProgressBar(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
    }

	
	///Test if algorithm creates center count properly
	func test_CenterCountEqualToNumberOfSteps() {
		
		let count = 5
		
		
		progressBar.stepCount = count
		
		//Why doesn't it call automatically?
		progressBar.draw(progressBar.bounds)
		
		XCTAssertEqual(count, progressBar.centers.count)
	}
	
	///Test if centers are calculated properly.
	func test_firstCenterXEqualToRadius() {
		progressBar.draw(progressBar.bounds)
		XCTAssertEqual(progressBar.centers[0].x, progressBar.radius)
	}
	
	///Test if centers are calculated properly.
	func test_lastCenterXEqualDistanceToEndFrame() {
		progressBar.draw(progressBar.bounds)
		XCTAssertEqual(progressBar.bounds.width - (progressBar.centers[progressBar.stepCount - 1].x), progressBar.radius)
	}
	
	
	
	
    override func tearDown() {
		super.tearDown()
		
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}



//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
