//
//  A000045.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A000045

    Generates the Fibonacci sequence. The next element in the sequence is defined as the
    sum of the previous two.

    First 10 elements:
  
      0, 1, 1, 2, 3, 5, 8, 13, 21, 34
*/
class A000045: InfiniteSequenceGenerator, RecursiveSequenceGenerator {
  // Properties
  typealias Element = LInt
  var index: Int { get { return elements.count - 1 } }
  var elements: [LInt] = []
  
  // Class variables
  static let description = "Fibonacci sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> LInt? {
    return iterateTo(index, elements.count) { self.next() }
  }
  
  // Sequence generation
  func next() -> LInt? {
    if index < 0 { elements.append(LInt()); return LInt() }
    if index == 0 { elements.append(LInt(1)); return LInt(1)}
    elements.append(elements[index] + elements[index-1])
    return elements.last
  }
}