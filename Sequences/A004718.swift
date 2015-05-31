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
class A004718: InfiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = Int
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [Int] = []
  var last: Int? = nil
  let description = "Per Nørgård's infinity sequence"
  
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
    if index < 0 { elements.append(0); return 0 }
    var res = 0
    if (index+1)%2 == 0 {
      res = -elements[(index+1)/2]
    } else {
      res = elements[(index)/2] + 1
    }
    elements.append(res)
    return res
  }
}