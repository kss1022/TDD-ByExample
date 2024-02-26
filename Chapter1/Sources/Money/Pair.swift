//
//  Pair.swift
//
//
//  Created by 한현규 on 2/23/24.
//

import Foundation



struct Pair: Hashable{
    private let from: String
    private let to: String
    
    init(_ from: String, _ to: String) {
        self.from = from
        self.to = to
    }
}
