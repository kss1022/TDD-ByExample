//
//  TestCase.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation


class TestCase: NSObject{
    
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    func setup(){
        
    }    
    
    func run(_ result: TestResult){
        result.testStarted()
        setup()
        do{
            try gatattar(self.name)
        }catch{
            result.testFailed()
        }
        
        tearDown()
    }
  
    
    func tearDown(){
        
    }
}


extension TestCase{
    func gatattar(_ functionName: String) throws{
        let selector = Selector(functionName)
        if self.responds(to: selector) {
            _ = self.perform(selector)
        }else{
            print("Function not found: \(functionName)")
        }
    }
    
    func gatattar(_ anyClass: AnyClass?,  _ functionName: String){
        if let method = class_getMethodImplementation(anyClass, Selector(functionName)) {
            typealias MyFunctionType = @convention(c) (AnyObject, Selector) -> Void
            let function = unsafeBitCast(method, to: MyFunctionType.self)
            function(self, Selector(functionName))
        } else {
            print("Function not found")
        }
    }

}
