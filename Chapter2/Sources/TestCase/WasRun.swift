//
//  WasRun.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class WasRun: TestCase{
        
    var log: String
    
    override init(_ name: String) {
        log = ""
        super.init(name)
    }
    
    override func setup(){
        super.setup()
        log = "setUp"
    }
    
    override func tearDown() {
        super.tearDown()
        log = self.log + " tearDown"
    }

    @objc
    func testMethod(){
        log = self.log + " testMethod"
    }
    
    @objc
    func testBrokenMethod(){
        assertionFailure()
    }
}

