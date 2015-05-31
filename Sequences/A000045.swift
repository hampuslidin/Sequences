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
class A000045: InfiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = LInt
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [LInt] = []
  var last: LInt? = nil
  let description = "Fibonacci sequence"
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<LInt>
  let startIndex: Int = 0
  var endIndex: Int { get { return elements.count } }
  
  subscript(i: Int) -> LInt {
    return iterateTo(i, elements.count) { self.next(currentIndex: self.index)! }!
  }
  
  func generate() -> SGeneratorOf<LInt> { return SGeneratorOf<LInt>(next) }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> LInt? {
    if cur_i < index { return elements[cur_i+1] }
    if index < 0 { elements.append(0); return 0 }
    if index == 0 { elements.append(1); return 1}
    var res = elements[index] + elements[index-1]
    elements.append(res)
    return res
  }
}