//
//  Expression.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



protocol Expression{      
    func times(_ multipiler: Int) -> Expression
    func plus(_ addend: Expression) -> Expression
    func reduce(_ bank: Bank, _ to: String) -> Money
}
