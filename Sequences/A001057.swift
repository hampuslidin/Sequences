//
//  A001057.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import Darwin

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A056239

    Generates the integer sequence.

    First 10 elements:
  
      0, 1, -1, 2, -2, 3, -3, 4, -4, 5
*/
class A001057: InfiniteSequenceGenerator, ExplicitSequenceGenerator {
  // Properties
  typealias Element = Int
  var index: Int = -1
  
  // Class variables
  static let description = "Integer sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> Int? {
    return -((index+1)/2*Int(pow(-1.0, Double(index%2))))
  }
  
  func next() -> Int? {
    return get(++index)
  }
}