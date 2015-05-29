//
//  A181391.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A181391

    Generates the Van Eck sequence. The first element is 0, then each new
    element is calculated by looking at the previous element. If the element
    appears for the first time, then the next element is 0. Otherwise the next
    element is the number of elements since that element appeared last time.

    First 10 elements:

      0, 0, 1, 0, 2, 0, 2, 2, 1, 6
*/
class A181391: InfiniteSequenceGenerator, RecursiveSequenceGenerator {
  // Properties
  typealias Element = UInt
  var index: Int { get { return elements.count-1 } }
  var elements: [UInt] = []
  
  // Class variables
  static let description = "Van Eck sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> UInt? {
    return iterateTo(index, elements.count) { self.next() }
  }
  
  func next() -> UInt? {
    if index < 0 { elements.append(0); return 0 }
    var k = index-1
    while k >= 0 && elements.last! != elements[k] {
      k--
    }
    if k < 0 { elements.append(0) }
    else { elements.append(UInt(index-k)) }
    return elements.last
  }
}