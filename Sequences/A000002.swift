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
class A000002: InfiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = Int
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [Int] = []
  var last: Int? = nil
  var runIndex = 0
  let description = "Kolakoski sequence"
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<Int>
  let startIndex: Int = 0
  var endIndex: Int { get { return elements.count } }
  
  subscript(i: Int) -> Int {
    return iterateTo(i, elements.count) { self.next(currentIndex: self.index)! }!
  }
  
  func generate() -> SGeneratorOf<Int> { return SGeneratorOf<Int>(next) }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> Int? {
    if cur_i < index { return elements[cur_i+1] }
    if index < 0 { elements.append(1); return 1 }
    var res = 0
    if elements[runIndex] == 1 ||
        elements[index] == elements[index-1] {
      res = elements[index]%2+1
      runIndex++
    } else if elements[runIndex] == 2 {
      res = elements[index]
    }
    elements.append(res)
    return res
  }
}
