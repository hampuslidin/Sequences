//
//  A000040.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A000040

    Generates the prime numbers. A prime number is only divisible by 1 and itself.

    First 10 elements:
  
      2, 3, 5, 7, 11, 13, 17, 19, 23, 29
*/
class A000040: InfiniteSequenceGenerator, RecursiveSequenceGenerator {
  // Properties
  typealias Element = UInt
  var index: Int { get { return elements.count-1 } }
  var elements: [UInt] = []
  
  // Class variables
  static let description = "Prime numbers"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> UInt? {
    return iterateTo(index, elements.count) { self.next() }
  }
  
  func next() -> UInt? {
    if index < 0 { elements.append(2); return 2 }
    var k = elements[index]
    while factorize(Int(++k)).count != 1 {}
    elements.append(k)
    return k
  }
}