//
//  Money.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class Money: Expression, Equatable{
    let amount: Int
    let currency: String
    
    init(_ amount: Int, _ currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    static func dollar(_ amount: Int) -> Money{
        Money(amount, "USD")
    }
    
    static func franc(_ amount: Int) -> Money{
        Money(amount, "CHF")
    }
    
    func times(_ multiplier: Int) -> Expression{
        Money(amount * multiplier, currency)
    }
    
    func plus(_ addend: Expression) -> Expression{
        Sum(self, addend)
    }
    
    func reduce(_ bank: Bank, _ to : String) -> Money{
        let rate = bank.rate(currency, to)
        return Money(amount / rate, to)
    }
    
    
    static func == (lhs: Money, rhs: Money) -> Bool {
        lhs.currency == rhs.currency &&
         lhs.amount == rhs.amount
    }

}


extension Money: CustomStringConvertible{
    var description: String{
        "\(amount) \(currency)"
    }
}
