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
class A181391: InfiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = UInt
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [UInt] = []
  var last: UInt? = nil
  let description = "Van Eck sequence"
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<UInt>
  let startIndex: Int = 0
  var endIndex: Int { get { return elements.count } }
  
  subscript(i: Int) -> UInt {
    return iterateTo(i, elements.count) { self.next(currentIndex: self.index)! }!
  }
  
  func generate() -> SGeneratorOf<UInt> { return SGeneratorOf<UInt>(next) }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> UInt? {
    if cur_i < index { return elements[cur_i+1] }
    var k = index-1, res: UInt = 0
    while k >= 0 && elements.last! != elements[k] {
      k--
    }
    if k < 0 {
      res = 0
    } else {
      res = UInt(index-k)
    }
    elements.append(res)
    return res
  }
}