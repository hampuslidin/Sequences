//
//  A056239.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A056239

    Generates the sequence of the sum of the parts of a partition, having Heinz
    number `n`. A partition `p = [p₁, p₂, ... , pᵣ]` has the Heinz
    number `prime(1) * prime(2) * ... * prime(r)`, where `prime(i)` is the i-th prime
    number. Therefore the sequence consists of `∑p𝒏 = p₁ + p₂ + ... + pᵣ`.

    First 10 elements:
  
      0, 1, 2, 2, 3, 3, 4, 3, 4, 4
*/
class A056239: InfiniteSType, ExplicitSType {
  // MARK: - Properties
  typealias ValueType = UInt
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int = -1
  var last: UInt? = nil
  let description = "Sum of Heinz number partitions sequence"
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<UInt>
  let startIndex: Int = 0
  var endIndex: Int { get { return index + 1 } }
  
  subscript(i: Int) -> UInt {
    return next(currentIndex: i)!
  }
  
  func generate() -> SGeneratorOf<UInt> { return SGeneratorOf<UInt>(next) }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> UInt? {
    var res: UInt = 0
    for pf in factorize(cur_i+2) {
      for p in A000040() {
        res++
        if pf == Int(p) { break }
      }
    }
    index++
    return res
  }
}