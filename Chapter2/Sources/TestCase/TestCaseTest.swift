//
//  TestCaseTest.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class TestCaseTest: TestCase{

    
    static func suite() -> TestSuite{
        let suite = TestSuite()
        
        suite.add(TestCaseTest("testTemplateMethod"))
        suite.add(TestCaseTest("testResult"))
        suite.add(TestCaseTest("testFailedResult"))
        suite.add(TestCaseTest("testFailedResultFormatting"))

        return suite
    }
    

    @objc
    func testTemplateMethod(){
        let test = WasRun("testMethod")
        let result = TestResult()
        test.run(result)
        assert("setUp testMethod tearDown" == test.log)
    }
    
    @objc
    func testResult(){
        let test = WasRun("testMethod")
        let result = TestResult()
        test.run(result)
        assert("1 run, 0 failed" == result.summery())
    }
    
    @objc
    func testFailedResult() {
        let test = WasRun("testBrokenMethod")        
        let result = TestResult()
        test.run(result)
        assert("1 run, 1 failed" == result.summery())
    }
    
    @objc
    func testFailedResultFormatting(){
        let result = TestResult()
        result.testStarted()
        result.testFailed()
        assert("1 run, 1 failed" == result.summery())
    }       
}



