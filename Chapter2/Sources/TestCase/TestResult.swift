//
//  TestResult.swift
//
//
//  Created by 한현규 on 2/26/24.
//

import Foundation


class TestResult{
    var runCount = 0
    var failedCount = 0
    
    init() {
        self.runCount = 0
        self.failedCount = 0
    }
    
    func testStarted(){
        self.runCount += 1
    }
    
    func testFailed(){
        self.failedCount += 1
    }
    
    func summery() -> String{
        "\(runCount) run, \(failedCount) failed"
    }
}
