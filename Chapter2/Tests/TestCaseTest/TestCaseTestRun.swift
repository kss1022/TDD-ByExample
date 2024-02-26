import XCTest
@testable import TestCase

final class TestCaseTestRun: XCTestCase {
    
    
    func testWasRun(){
        let suite = TestCaseTest.suite()
        let result = TestResult()
        suite.run(result)
        print(result.summery())
    }
}
