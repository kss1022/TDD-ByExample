//
//  Bank.swift
//  
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



class Bank{
    
    private var rates: [Pair: Int]
    
    init() {
        self.rates = [:]
    }
    
    func addRate(_ from: String, _ to: String, _ rate: Int){
        self.rates[Pair(from, to)] =  rate
    }
    
    func reduce(_ source: Expression, _ to: String) -> Money{
        source.reduce(self, to)
    }
        
    func rate(_ from: String, _ to : String) -> Int{
        if from == to{
            return 1
        }
        
        return rates[Pair(from, to)] ?? 1
    }
    
}
