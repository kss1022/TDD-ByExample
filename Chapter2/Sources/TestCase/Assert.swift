//
//  Assert.swift
//
//
//  Created by 한현규 on 2/26/24.
//

import Foundation
    


func Assert(_ expression: @autoclosure () throws -> Bool) throws{
    do{
        if try !expression(){
            //fail
            throw AssertError.AssertFail
        }
    }catch{
        //fail
        throw AssertError.AssertFail
    }
}


enum AssertError: Error{
    case AssertFail
}
