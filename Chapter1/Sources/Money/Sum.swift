//
//  File.swift
//  
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class Sum: Expression{
    let augent: Expression
    let addend: Expression
    
    init(_ augent: Expression, _ addend: Expression) {
        self.augent = augent
        self.addend = addend
    }
    
    func times(_ multiplier: Int) -> Expression{
        Sum(augent.times(multiplier), addend.times(multiplier))
    }
    
    func plus(_ addend: Expression) -> Expression {
        Sum(self, addend)
    }
    
    func reduce(_ bank: Bank, _ to: String) -> Money{
        let amount = bank.reduce(augent, to).amount + bank.reduce(addend, to).amount
        return Money(amount, to)
    }
}
