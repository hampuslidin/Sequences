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
class A056239: InfiniteSequenceGenerator, ExplicitSequenceGenerator {
  // Properties
  typealias Element = UInt
  var index: Int = -1
  
  // Class variables
  static let description = "Sum of Heinz number partitions sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> UInt? {
    var res: UInt = 0
    for pf in factorize(index+1) {
      for p in IntegerSequence<A000040>() {
        res++
        if pf == Int(p) { break }
      }
    }
    return res
  }
  
  func next() -> UInt? {
    return get(++index)
  }
}