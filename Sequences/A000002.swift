//
//  A000002.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A000002

    Generates the Kolakoski sequence. The sequence only contains 1's and 2's,
    and the first element is 1. Each element indicates the length of the runs
    of 1's or 2's that the sequence has produced so far. More formally, a[n]
    is the length of the (n+1)-th run.

    First 10 elements:
  
      1, 2, 2, 1, 1, 2, 1, 2, 2, 1
*/
class A000002: InfiniteSequenceGenerator, RecursiveSequenceGenerator {
  // Properties
  typealias Element = Int
  var index: Int { get { return elements.count-1 } }
  var elements: [Int] = []
  var runIndex = 0
  
  // Class variables
  static let description = "Kolakoski sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> Int? {
    return iterateTo(index, elements.count) { self.next() }
  }
  
  func next() -> Int? {
    if index < 0 { elements.append(1); return 1 }
    if elements[runIndex] == 1 || elements[index] == elements[index-1] {
      elements.append(elements[index]%2+1)
      runIndex++
    } else if elements[runIndex] == 2 {
      elements.append(elements[index])
    }
    return elements.last
  }
}
