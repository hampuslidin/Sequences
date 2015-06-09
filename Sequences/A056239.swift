//
//  A056239.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A056239

    Generates the sequence of the sum of the parts of a partition, having Heinz
    number `n`. A partition `p = [p₁, p₂, ... , pᵣ]` has the Heinz
    number `prime(1) * prime(2) * ... * prime(r)`, where `prime(i)` is the i-th prime
    number. Therefore the sequence consists of `∑p𝒏 = p₁ + p₂ + ... + pᵣ`.

    First 10 elements:
  
      0, 1, 2, 2, 3, 3, 4, 3, 4, 4
*/
public class A056239: ExplicitS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA056239,
      description: "Sum of Heinz number partitions sequence", nextElement: {
        var res: LInt = 0
        for pf in factorize($0+1) {
          for p in A000040() {
            res++
            if LInt(pf) == p { break }
          }
        }
        return res
      }
    )
  }
}