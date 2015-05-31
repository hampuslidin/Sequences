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
class A000040: InfiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = UInt
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [UInt] = []
  var last: UInt? = nil
  let description = "Prime numbers"
  
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
    if index < 0 { elements.append(2); return 2 }
    var k = elements[index]
    while factorize(Int(++k)).count != 1 {}
    elements.append(k)
    return k
  }
}