//
//  A244471.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A244471

    Generates the sequence of integers with the property that if a vertical line
    is drawn between any adjacent pair of digits in the sequence, the number
    formed to the left of the line is divisible by the single digit to the right.
    The sequence contains the smallest numbers that has this property.

    First 20 elements:
  
      1, 11, 3, 7, 71, 31, 111, 113, 33, 117
*/
class A244471: InfiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = LInt
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [LInt] = []
  var last: LInt? = nil
  let description = "Vertical line divisible sequence"
  
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
    var factors: [LInt] = [LInt(1),LInt(3),LInt(7),LInt(9)]
    let z = concatenateNumbers(elements)
    var res = findDivisor(z, factors: factors, seq: elements)
    elements.append(res)
    return res
  }
  
  private func concatenateNumbers(list: [LInt]) -> LInt {
    if list.isEmpty { return 0 }
    var z = list[0]
    for var i = 1; i < list.count; i++ {
      z *= magnitude(list[i])*10
      z += list[i]
    }
    return z
  }
  
  private func magnitude(n: LInt) -> LInt {
    var mag = LInt(1)
    while n/(mag*10) != 0 {
      mag *= 10
    }
    return mag
  }
  
  private func findDivisor(z: LInt, factors: [LInt], seq: [LInt]) -> LInt {
    var newFactors = [LInt]()
    for elem in factors {
      let (a,b) = split(elem)
      let concat = a != 0 ? concatenateNumbers([z, a]) : z
      if (concat%b == 0) {
        newFactors.append(elem)
        if !member(elem, list: seq) {
          return elem
        }
      }
    }
    return findDivisor(z, factors: magnify(newFactors), seq: seq)
  }
  
  private func split(n: LInt) -> (LInt, LInt) { return (n/10, n%10) }
  
  private func member(elem: LInt, list: [LInt]) -> Bool {
    for e in list {
      if e == elem { return true }
    }
    return false
  }
  
  private func magnify(list: [LInt]) -> [LInt] {
    var res = [LInt]()
    for elem in list {
      res.append(elem*10+1)
      res.append(elem*10+3)
      res.append(elem*10+7)
      res.append(elem*10+9)
    }
    return res
  }
}