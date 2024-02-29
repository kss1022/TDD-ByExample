//
//  CharBuffer.swift
//
//
//  Created by 한현규 on 2/27/24.
//

import Foundation


public struct CharHeader {
    var position: Int
    var limit: Int
}

public final class CharBuffer: ManagedBuffer<CharHeader, UInt8> {
        
    static func create(capacity: Int) -> CharBuffer {
        unsafeDowncast(
            CharBuffer.create(minimumCapacity: capacity) { buffer in
                buffer.withUnsafeMutablePointerToElements { pointer in
                    pointer.initialize(repeating: 0, count: capacity)
                }
                //print("\(buffer.capacity)")
                return CharHeader(position: 0, limit: buffer.capacity)
            },
            to: Self.self
        )
    }
    
    //readMode
    public func flip(){
        setLimit(position)
        setPosition(0)
    }
    
    //writeMode
    public func compact(){
        withUnsafeMutablePointerToElements { pointer in            
            var advanced = 0
             
            for i in position..<limit{
                let charAt = (pointer+i).pointee
                (pointer+advanced).pointee = charAt
                advanced += 1
            }
            
            setPosition(advanced)
            setLimit(capacity)
        }
    }
    
    
    public func put(_ charater: Character){
        withUnsafeMutablePointerToElements { pointer in
            (pointer + position).pointee = charater.uInt8()
            setPosition(position+1)
        }
    }
    
    public func put(_ string: String){
        for char in string{
            put(char)
        }
    }
    
    public func get() -> Character{
        let result = withUnsafeMutablePointerToElements { pointer in
            return (pointer+position).pointee
        }.char()
        
        setPosition(position+1)
        return result
    }
    
    public func get(_ index: Int) -> Character{
        let result =  withUnsafeMutablePointerToElements { pointer in
            return (pointer+index).pointee
        }
        return result.char()
    }
    
    
    
    public func string() -> String{
        withUnsafeMutablePointerToElements{ pointer in
            let bufferPointer = UnsafeBufferPointer<UInt8>(start: pointer, count: capacity)
            
            return bufferPointer[0..<limit].map(UnicodeScalar.init)
                .map(String.init)
                .joined()
        }
    }

    
    public func subString(_ from: Int,_ to: Int) -> String{
        withUnsafeMutablePointerToElements { pointer in
            let bufferPointer = UnsafeBufferPointer<UInt8>(start: pointer, count: capacity)
            return bufferPointer[from..<to].map(UnicodeScalar.init)
                .map(String.init)
                .joined()
        }
    }
    
    public func readOnlyBuffer() -> CharBuffer{
        unsafeDowncast(
            CharBuffer.create(minimumCapacity: capacity) { buffer in
                buffer.withUnsafeMutablePointerToElements { pointer in
                    pointer.initialize(repeating: 0, count: capacity)
                }
                
                
                self.withUnsafeMutablePointerToElements {  pointer in
                    buffer.withUnsafeMutablePointerToElements{ newPointer in
                        newPointer.initialize(from: pointer, count: capacity)
                    }
                }
                
                return CharHeader(position: self.position, limit: self.limit)
            },
            to: Self.self
        )
    }

        
}
public extension CharBuffer{
    var limit: Int{
        header.limit
    }
    
    func setLimit(_ limit: Int){
        header.limit = limit
    }
    
    var position: Int{
        header.position
    }
    
    func setPosition(_ position: Int){
        header.position = position
    }
    
    var remaining: Int{
        header.limit - header.position
    }

}


fileprivate extension UInt8{
    func char() -> Character{
        Character( UnicodeScalar(self) )
    }
}

fileprivate extension Character{
    func uInt8() -> UInt8{
        self.asciiValue!
    }
}
