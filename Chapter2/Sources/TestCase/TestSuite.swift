//
//  TestSuite.swift
//
//
//  Created by 한현규 on 2/26/24.
//

import Foundation


class TestSuite{
 
    var tests: [TestCaseTest]
    
    init() {
        self.tests = []
    }
    
    func add(_ testCase: TestCaseTest){
        self.tests.append(testCase)
    }
    
    func run(_ result: TestResult){
        for test in tests {
            test.run(result)
        }        
    }
}
