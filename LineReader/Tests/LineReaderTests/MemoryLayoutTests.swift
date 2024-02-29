//
//  MemoryLayoutTests.swift
//  
//
//  Created by 한현규 on 2/29/24.
//

import XCTest


/**
 *      https://theswiftdev.com/memory-layout-in-swift/
 *      Size: to save things perfectly aligned on a memory buffer
 *      Stride: will tell you about the distance between two elements on the buffer
 *      Alignment: how much memory is needed to save things perfectly aligned on a memory buffer
 *
 */


final class MemoryLayoutTests: XCTestCase {
        
    
    func testBoolSizes(){
        XCTAssertEqual(1, MemoryLayout<Bool>.size)
        XCTAssertEqual(1, MemoryLayout<Bool>.stride)
        XCTAssertEqual(1, MemoryLayout<Bool>.alignment)
    }
    
    func testCharSizes(){
        XCTAssertEqual(1, MemoryLayout<UInt8>.size)
        XCTAssertEqual(1, MemoryLayout<UInt8>.stride)
        XCTAssertEqual(1, MemoryLayout<UInt8>.alignment)
    }
    
    func testCharacterSizes(){   //Unicode
        XCTAssertEqual(16, MemoryLayout<Character>.size)
        XCTAssertEqual(16, MemoryLayout<Character>.stride)
        XCTAssertEqual(8, MemoryLayout<Character>.alignment)
    }
    
    func testIntSizes(){
        XCTAssertEqual(8, MemoryLayout<Int>.size)
        XCTAssertEqual(8, MemoryLayout<Int>.stride)
        XCTAssertEqual(8, MemoryLayout<Int>.alignment)
    }
    
    func testFloatSizes(){
        XCTAssertEqual(4, MemoryLayout<Float>.size)
        XCTAssertEqual(4, MemoryLayout<Float>.stride)
        XCTAssertEqual(4, MemoryLayout<Float>.alignment)
    }
    
    func testCGFloatSizes(){
        XCTAssertEqual(8, MemoryLayout<CGFloat>.size)
        XCTAssertEqual(8, MemoryLayout<CGFloat>.stride)
        XCTAssertEqual(8, MemoryLayout<CGFloat>.alignment)
    }
    
    func testDoubleSizes(){
        XCTAssertEqual(8, MemoryLayout<Double>.size)
        XCTAssertEqual(8, MemoryLayout<Double>.stride)
        XCTAssertEqual(8, MemoryLayout<Double>.alignment)
    }
    
    func testStruct1Sizes(){
        //Int After Bool
        XCTAssertEqual(9, MemoryLayout<Struct1>.size)
        XCTAssertEqual(16, MemoryLayout<Struct1>.stride)
        XCTAssertEqual(8, MemoryLayout<Struct1>.alignment)
    }
    
    func testStruct2Sizes(){
        //Bool After Int
        XCTAssertEqual(16, MemoryLayout<Struct2>.size)
        XCTAssertEqual(16, MemoryLayout<Struct2>.stride)
        XCTAssertEqual(8, MemoryLayout<Struct2>.alignment)
    }
    
    
    func testClass1Sizes(){
        XCTAssertEqual(8, MemoryLayout<Class1>.size)
        XCTAssertEqual(8, MemoryLayout<Class1>.stride)
        XCTAssertEqual(8, MemoryLayout<Class1>.alignment)
    }
    
    func testClassInstanceSizes(){
        XCTAssertEqual(16, class_getInstanceSize(Empty.self))   // "is a" pointer and the reference count
        XCTAssertEqual(32, class_getInstanceSize(Class1.self))
    }
  
}



struct Struct1 {
    let foo: Int  // 8
    let bar: Bool // 1
}

struct Struct2{
    let bar: Bool // 1
    let foo: Int  // 8
}


class Empty{
}

class Class1{
    let foo: Int  // 8
    let bar: Bool // 1
    
    init(foo: Int, bar: Bool) {
        self.foo = foo
        self.bar = bar
    }
}
