import XCTest
@testable import TestCase

final class TestCaseTestRun: XCTestCase {
    
    
    func testWasRun(){
        let suite = TestSuite()
        
        suite.add(TestCaseTest("testTemplateMethod"))
        suite.add(TestCaseTest("testResult"))
        suite.add(TestCaseTest("testFailedResult"))
        suite.add(TestCaseTest("testFailedResultFormatting"))
        suite.add(TestCaseTest("testSuite"))

        let result = TestResult()
        suite.run(result)
        print(result.summery())
    }
}
