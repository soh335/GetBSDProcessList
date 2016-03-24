//
//  GetBSDProcessListTests.swift
//  GetBSDProcessListTests
//
//  Created by soh kitahara on 2016/03/24.
//
//

import XCTest
import GetBSDProcessList

class GetBSDProcessListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let pCommToString = { (p: UnsafePointer<Void>) -> String? in
            String.fromCString(UnsafePointer<CChar>(p))
        }
        let procs = GetBSDProcessList()
        XCTAssertNotNil(procs)
        var found = false
        for proc in procs! {
            var pComm = proc.kp_proc.p_comm
            guard let comm = pCommToString(&pComm) else {
                continue
            }
            if comm.containsString("xctest") {
                found = true
                break
            }
        }
        XCTAssert(found)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
