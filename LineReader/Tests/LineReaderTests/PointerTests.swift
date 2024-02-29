//
//  PointerTests.swift
//
//
//  Created by 한현규 on 2/29/24.
//

import XCTest

/**
 *  https://theswiftdev.com/unsafe-memory-pointers-in-swift/
 */


final class PointerTests: XCTestCase {
    
    
    func testChangeValueByPointer(){
        var x: Int = 10
        var xPointer: UnsafeMutablePointer<Int> = .init(&x)
        
        //        print("xAddress: \(UnsafeRawPointer(&x))")
        //        print("xValue: \(x)")
        //        
        //        print("xPointerAddress: \(UnsafeRawPointer(&xPointer))")
        //        print("(xPointerValue: \(xPointer.pointee))")
        
        xPointer.pointee = 20
        
        XCTAssertEqual(20, x)
        XCTAssertEqual(20, xPointer.pointee)
    }
    
    func testChangeValue(){
        var x: Int = 10
        let xPointer: UnsafeMutablePointer<Int> = .init(&x)
        
        x = 20
        
        XCTAssertEqual(20, x)
        XCTAssertEqual(20, xPointer.pointee)
    }
    
    func testStoreMemoery(){
        let nums = [1,2,3,4,5]
        
        let pointer = UnsafeMutablePointer<Int>.allocate(capacity: nums.count)
        pointer.initialize(repeating: 0, count: nums.count)
        
        defer{
            pointer.deinitialize(count: nums.count)
            pointer.deallocate()
        }
        
        for i in 0..<nums.count{
            (pointer+i).pointee = i + 1
        }
                
        for i in 0..<nums.count{
            XCTAssertEqual(nums[i], (pointer+i).pointee)
        }
        
        let bufferPointer = UnsafeBufferPointer<Int>(start: pointer, count: nums.count)
        //bufferPointer[0] = 10  -> Use MutableBufferPointer
        bufferPointer.enumerated().forEach { enumerated in
            XCTAssertEqual(nums[enumerated.offset], enumerated.element)
        }
        
        let bufferMutablePointer = UnsafeMutableBufferPointer<Int>(start: pointer, count: nums.count)
        for i in 0..<nums.count{
            bufferMutablePointer[i] = nums[i] * 10
        }
                
        //Nums Not Change
        bufferMutablePointer.enumerated().forEach { enumerated in
            XCTAssertNotEqual(nums[enumerated.offset], enumerated.element)
        }
        
    }
    
    
    func testStorePointer2(){
        let nums = [1,2,3,4,5]
        
        let stride = MemoryLayout<Int>.stride
        let alignment = MemoryLayout<Int>.alignment
        let byteCount = stride * nums.count
        
        let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
        defer{
            pointer.deallocate()
        }
        
        for (index, value) in nums.enumerated(){
            pointer.advanced(by: stride * index).storeBytes(of: value, as: Int.self)
        }
        
        for i in 0..<nums.count{
            let value = (pointer+stride*i).load(as: Int.self)
            XCTAssertEqual(nums[i], value)
        }
        
        
        //let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
        let bufferPointer = UnsafeMutableRawBufferPointer(start: pointer, count: byteCount)
        for i in 0..<nums.count {
            //bufferPointer+stride*i: error
            let value = bufferPointer.load(fromByteOffset: stride * i, as: Int.self)
            XCTAssertEqual(nums[i], value)
        }
    }
    
    
    func testSimpleUseRawPointer(){
        let count = 2
        let stride = MemoryLayout<Int>.size
        let alignment = MemoryLayout<Int>.alignment
        let byteCount = stride * count
        
        let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
        defer{
            pointer.deallocate()
        }

        
        pointer.storeBytes(of: 30, as: Int.self)
        (pointer+stride).storeBytes(of: 3, as: Int.self)
        
        XCTAssertEqual(30, pointer.load(as: Int.self))
        XCTAssertEqual(3, (pointer+stride).load(as: Int.self))
        
        let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
        
        for i in 0..<count{
            let value = bufferPointer.load(fromByteOffset: stride * i, as: Int.self)
            print("Index \(i) -> \(value)")
        }
                        
        
        for (index, byte) in bufferPointer.enumerated() {
          print("byte \(index) -> \(byte)")
        }
    }
    
    func testSimpleUsePointer(){
        let count = 2
        let stride = MemoryLayout<Int>.stride
        let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
        pointer.initialize(repeating: 0, count: count)
        
        defer {
          pointer.deinitialize(count: count)
          pointer.deallocate()
        }
        
        pointer.pointee = 42
        
        (pointer+1).pointee = 6
        let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
        for (index, value) in bufferPointer.enumerated() {
          print("value \(index) -> \(value)")
        }
    }
    
        
    
    func testBindPointer(){
        let stride = MemoryLayout<Int>.stride
        let alignment = MemoryLayout<Int>.alignment
        let count = 1
        let byteCount = stride * count

        let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
        defer {
            rawPointer.deallocate()
        }
        
        let pointer = rawPointer.bindMemory(to: Int.self, capacity: count)
        //let pointer = rawPointer.assumingMemoryBound(to: Int.self)
        pointer.initialize(repeating: 0, count: count)
        defer {
            pointer.deinitialize(count: count)
        }

        pointer.pointee = 42
        print()
        XCTAssertEqual(42, rawPointer.load(as: Int.self))
                
        rawPointer.storeBytes(of: 69, toByteOffset: 0, as: Int.self)
        XCTAssertEqual(69, pointer.pointee)

        
        
        
        // don't do this, use withMemoryRebound instead...
        let badPointer = rawPointer.bindMemory(to: Bool.self, capacity: count)
        print(badPointer.pointee) // true, but that's not what we expect, right?
         
        pointer.withMemoryRebound(to: Bool.self, capacity: count) { boolPointer in
            print(boolPointer.pointee) // false
        }

        // never return the pointer variable inside the block
        withUnsafeBytes(of: &pointer.pointee) { pointer -> Void in
            for byte in pointer {
                print(byte)
            }
            // don't return pointer ever
        }

        // off-by-one error...
        let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount + 1)
        for byte in bufferPointer {
            print(byte) // ...the last byte will be problematic
        }
    }
    
}
