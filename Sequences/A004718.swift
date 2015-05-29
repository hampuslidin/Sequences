//
//  A004718.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A004718

    Generates Per Nørgård's infinity sequence, where `a[2n] = -a[n]`, `a[2n+1] = a[n] + 1`
    and `a[0] = 0`.

    First 10 elements:
  
      0, 1, -1, 2, 1, 0, -2, 3, -1, 2
*/
class A004718: InfiniteSequenceGenerator, RecursiveSequenceGenerator {
  // Properties
  typealias Element = Int
  var index: Int { get { return elements.count-1 } }
  var elements: [Int] = []
  
  // Class variables
  static let description = "Per Nørgård's infinity sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> Int? {
    return iterateTo(index, elements.count) { self.next() }
  }
  
  func next() -> Int? {
    if index < 0 { elements.append(0); return 0 }
    if (index+1)%2 == 0 {
      elements.append(-elements[(index+1)/2])
    } else {
      elements.append(elements[(index)/2] + 1)
    }
    return elements.last
  }
}