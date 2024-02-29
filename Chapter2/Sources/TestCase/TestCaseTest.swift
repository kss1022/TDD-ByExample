//
//  TestCaseTest.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class TestCaseTest: TestCase{

    var result: TestResult!
    
    override func setup() {
        result = TestResult()
        super.setup()
    }

    @objc
    func testTemplateMethod(){
        let test = WasRun("testMethod")
        test.run(result)
        assert("setUp testMethod tearDown" == test.log)
    }
    
    @objc
    func testResult(){
        let test = WasRun("testMethod")
        test.run(result)
        assert("1 run, 0 failed" == result.summery())
    }
    
    @objc
    func testFailedResult() {
        let test = WasRun("testBrokenMethod")        
        test.run(result)
        assert("1 run, 1 failed" == result.summery())
    }
    
    @objc
    func testFailedResultFormatting(){
        result.testStarted()
        result.testFailed()
        assert("1 run, 1 failed" == result.summery())
    }     
    
    @objc
    func testSuite(){
        let suite = TestSuite()
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.run(result)
        assert("1 run, 1 failed" == result.summery())
    }
}



