//
//  A001057.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import Darwin

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A056239

    Generates all the integers.

    First 10 elements:
  
      0, 1, -1, 2, -2, 3, -3, 4, -4, 5
*/
class A001057: InfiniteSType, ExplicitSType {
  // MARK: - Properties
  typealias ValueType = Int
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int = -1
  var last: Int? = nil
  let description = "All integers"
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<Int>
  let startIndex: Int = 0
  var endIndex: Int { get { return index + 1 } }
  
  subscript(i: Int) -> Int {
    return next(currentIndex: i)!
  }
  
  func generate() -> SGeneratorOf<Int> { return SGeneratorOf<Int>(next) }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> Int? {
    var res = -((cur_i+2)/2*Int(pow(-1.0, Double((cur_i+1)%2))))
    index++
    return res
  }
}