import XCTest
@testable import CharBuffer

final class CharBufferTests: XCTestCase {
    
    private var buffer: CharBuffer!
    
    override func setUp() {
        super.setUp()
        buffer = CharBuffer.create(capacity: 100)
    }
    
    
    func testPutChracter(){
        buffer.put("a")
        buffer.put("b")
        buffer.put("c")
        buffer.put("d")
        
        
        XCTAssertEqual("a", buffer.get(0))
        XCTAssertEqual("b", buffer.get(1))
        XCTAssertEqual("c", buffer.get(2))
        XCTAssertEqual("d", buffer.get(3))
    }
    
    func testPutNewLine(){
        buffer.put("\n")
        XCTAssertEqual("\n", buffer.get(0))
    }
    
    func testPutCharacters(){
        buffer.put("a\n")
        XCTAssertEqual("a", buffer.get(0))
        XCTAssertEqual("\n", buffer.get(1))
    }
    
    func testPutString(){
        buffer.put("abcde")
        
        XCTAssertEqual(5, buffer.position)
        XCTAssertEqual(buffer.capacity, buffer.limit)
        
        buffer.flip()
        XCTAssertEqual("abcde", buffer.string())
    }
    
    func testSubString(){
        buffer.put("abcd")                
        XCTAssertEqual("ab", buffer.subString(0, 2))
    }
    
    func testSubStringEmpty(){        
        XCTAssertEqual("", buffer.subString(0, 0))
    }
    
    func testSetLimit(){
        buffer.put("a")
        buffer.put("b")
        buffer.put("c")
        buffer.put("d")
        
        buffer.setLimit(100)
        
        XCTAssertEqual(100, buffer.limit)
    }
    
    func testSetPosition(){
        buffer.put("a")
        buffer.put("b")
        buffer.put("c")
        buffer.put("d")
        
        buffer.setPosition(100)
        
        XCTAssertEqual(100, buffer.position)
    }
    
    func testFlip(){
        buffer.put("a")
        buffer.put("b")
        buffer.put("c")
        buffer.put("d")
        buffer.flip()
        
        XCTAssertEqual(0, buffer.position)
        XCTAssertEqual(4, buffer.limit)
    }
    
    func testCompact(){
        buffer.put("a")
        buffer.put("b")
        buffer.put("c")
        buffer.put("d")
        buffer.put("e")
        
        buffer.flip()
        _ = buffer.get()
        _ = buffer.get()
        _ = buffer.get()
        
        
        buffer.compact()
        
        XCTAssertEqual("d", buffer.get(0))
        XCTAssertEqual("e", buffer.get(1))
        XCTAssertEqual(buffer.position, 2)
        XCTAssertEqual(buffer.capacity, buffer.limit)
    }
    
    
    func testCountZero(){
        XCTAssertEqual(buffer.capacity, buffer.remaining)
    }
    
    func testCountNotZero(){
        buffer.put("a")
        XCTAssertEqual(1, buffer.position)
        XCTAssertEqual(buffer.capacity, buffer.limit)
        XCTAssertEqual(buffer.capacity - 1, buffer.remaining)
    }
    
    func testReadOnlyBuffer(){
        buffer.put("a")
        
        let readOnly = buffer.readOnlyBuffer()
        
        XCTAssertEqual(buffer.position, readOnly.position)
        XCTAssertEqual(buffer.limit, readOnly.limit)
        XCTAssertEqual(buffer.capacity, readOnly.capacity)
        XCTAssertEqual(buffer.get(0), readOnly.get(0))
    }
     
    

}
