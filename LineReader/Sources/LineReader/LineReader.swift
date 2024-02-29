//
//  LineReader.swift
//
//
//  Created by 한현규 on 2/27/24.
//

import Foundation
import CharBuffer

class LineReader{
    
    private static let NOLINE: String? = nil
    private static let SEPARATOR = "\n"
    
    private let buffer: CharBuffer
    
    init(_ buffer: CharBuffer) {
        self.buffer = buffer
    }
    
    func readLine() -> String?{
        let readOnlyBuffer = buffer.readOnlyBuffer()
        readOnlyBuffer.flip()
        
        var result: String?
        
        let cutPosition  = getCutPosition(readOnlyBuffer)
        
        if hasNoLine(cutPosition){
            result =  LineReader.NOLINE
            return result
        }
        
        result =  getFirstLine(readOnlyBuffer, cutPosition)
        trimFirstLine(buffer, cutPosition)
        return result
    }
    
    func isEmpty(_ buffer: CharBuffer) -> Bool{
        buffer.remaining == 0
    }
    
    func getCutPosition(_ buffer: CharBuffer) -> Int{
        let pattern = try! NSRegularExpression(pattern: LineReader.SEPARATOR, options: [])
        let bufferString = buffer.string()
                
        guard let match = pattern.firstMatch(in: bufferString, range: .init(location: 0, length: bufferString.utf16.count)) else {
            return -1
        }
        
        return match.range.location //firstPositoin
    }
    
    private func hasNoLine(_ cutPosition: Int) -> Bool{
        cutPosition == -1
    }
    
    func trimFirstLine(_ buffer: CharBuffer, _ cutPosition: Int){
        let beforePosition = buffer.position
        let newPosition = beforePosition-(cutPosition+1)

        buffer.setLimit(buffer.capacity)
        buffer.setPosition(cutPosition+1)
        buffer.compact()
        
        buffer.setPosition(newPosition)
    }        
            
    
    func getFirstLine(_ buffer: CharBuffer, _ cutPosition: Int) -> String{
        if cutPosition == 0{
            return ""
        }
        
        return buffer.subString(0, cutPosition)
    }
    
}
