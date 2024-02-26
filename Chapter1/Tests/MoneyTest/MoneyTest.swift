import XCTest
@testable import Money

final class MoneyTest: XCTestCase {
    
    func testMultiplication(){
        let five = Money.dollar(5)
        
        XCTAssertEqual(Money.dollar(10), five.times(2) as! Money)
        XCTAssertEqual(Money.dollar(15), five.times(3) as! Money)
    }
            
    func testFrancMultiplication(){
        let five = Money.franc(5)
        XCTAssertEqual(Money.franc(10), five.times(2) as! Money)
        XCTAssertEqual(Money.franc(15), five.times(3) as! Money)
    }
    
    func testEquality(){
        XCTAssertEqual(Money.dollar(5), Money.dollar(5))
        XCTAssertNotEqual(Money.dollar(5), Money.dollar(6))
        XCTAssertNotEqual(Money.dollar(5), Money.franc(5))
    }
    
    func testSimpleAddition(){
        let five = Money.dollar(5)
        let sum = five.plus(five)
        
        let bank = Bank()
        let result = bank.reduce(sum, "USD")
                
        XCTAssertEqual(Money.dollar(10), result)
    }
    
    func testPlusReturnSum(){
        let five = Money.dollar(5)
        let result = five.plus(five)
        
        let sum = result as! Sum
        XCTAssertEqual(five, sum.augent as! Money)
        XCTAssertEqual(five, sum.addend as! Money)
    }
    
    func testReduceSum(){
        let sum = Sum(Money.dollar(3), Money.dollar(4))
        
        let bank = Bank()
        let result = bank.reduce(sum, "USD")
        XCTAssertEqual(Money.dollar(7), result)
    }
    
    func testReduceMoney(){        
        let bank = Bank()
        let result = bank.reduce(Money.dollar(5), "USD")
        XCTAssertEqual(Money.dollar(5), result)
    }
    
    func testReduceMoneyDiffrentCurrency(){
        let bank = Bank()
        bank.addRate("CHF", "USD", 2)
        let result = bank.reduce(Money.franc(10), "USD")
        XCTAssertEqual(Money.dollar(5) , result)
    }
    
    func testIdentityRate(){
        XCTAssertEqual(1, Bank().rate("USD", "USD"))
    }
    

    func testMixedAddition(){
        let fiveBucks: Expression = Money.dollar(5)
        let tenFrancs: Expression = Money.franc(10)
        
        let bank = Bank()
        bank.addRate("CHF", "USD", 2)
        
        let sum = fiveBucks.plus(tenFrancs)
        let result = bank.reduce(sum, "USD")
        
        XCTAssertEqual(Money.dollar(10), result)
    }
    
    func testSumPlusMoney(){
        let fiveBucks: Expression = Money.dollar(5)
        let tenFrancs: Expression = Money.franc(10)
        
        let bank = Bank()
        bank.addRate("CHF", "USD", 2)
        
        let sum = Sum(fiveBucks, tenFrancs).plus(fiveBucks)
        let result = bank.reduce(sum, "USD")
        
        XCTAssertEqual(Money.dollar(15), result)
    }
    
    func testSumTimes(){
        let fiveBucks: Expression = Money.dollar(5)
        let tenFrancs: Expression = Money.franc(10)
        
        let sum = Sum(fiveBucks, tenFrancs).times(2)
        
        let bank = Bank()
        bank.addRate("CHF", "USD", 2)
        let result = bank.reduce(sum, "USD")
        
        XCTAssertEqual(Money.dollar(20), result)
    }
}
