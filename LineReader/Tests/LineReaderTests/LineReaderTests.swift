import XCTest
@testable import LineReader
@testable import CharBuffer

final class LineReaderTests: XCTestCase {
    
    private var buffer: CharBuffer!
    private var reader: LineReader!
    
    override  func setUp() {
        super.setUp()
        
        self.buffer = CharBuffer.create(capacity: 100)
        self.reader = LineReader(buffer)
    }
    
    func testEmpty() throws {
        XCTAssertEqual(nil, reader.readLine())
        assertBufferState(buffer: buffer, pos: 0, limit: buffer.capacity)
    }
    
    func testNewLineOnly(){
        buffer.put("\n")
        XCTAssertEqual("", reader.readLine())
        assertBufferState(buffer: buffer, pos: 0, limit: buffer.capacity)
    }
    
    
    func testSomeThingAndNewLine(){
        buffer.put("a\n")
        XCTAssertEqual("a", reader.readLine())
        assertBufferState(buffer: buffer, pos: 0, limit: buffer.capacity)
    }
    
    func testTrimeFirstLine(){
        buffer.put("a\n")
        
        reader.trimFirstLine(buffer, reader.getCutPosition(buffer))
        assertBufferState(buffer: buffer, pos: 0, limit: buffer.capacity)
        
        let str = buffer.string()
        for i in 0..<buffer.capacity{
            let index = str.index(str.startIndex, offsetBy: i)
            XCTAssertEqual(str[index], "\0")
        }
    }
    
    func testTrimeFirstLineWithSomethingNewLineSomething(){
        buffer.put("a\nb")
        reader.trimFirstLine(buffer, reader.getCutPosition(buffer))
        assertBufferState(buffer: buffer, pos: 1, limit: buffer.capacity)
        XCTAssertEqual("b", buffer.get(0))
    }
    
    
    
    func testCutPositionEmpty(){
        buffer.flip()
        XCTAssertEqual(-1, reader.getCutPosition(buffer))
    }

    func testCutPositoinNewLine(){
        buffer.put("\n")
        buffer.flip()
        XCTAssertEqual(0, reader.getCutPosition(buffer))
    }
    
    func testCutPositionSomethingAndNewLine(){
        buffer.put("a\n")
        buffer.flip()
        XCTAssertEqual(1, reader.getCutPosition(buffer))
    }
    
}

extension LineReaderTests{
    func assertBufferState(buffer: CharBuffer,  pos: Int,limit: Int){
        XCTAssertEqual(pos, buffer.position)
        XCTAssertEqual(limit, buffer.limit)
    }
}
