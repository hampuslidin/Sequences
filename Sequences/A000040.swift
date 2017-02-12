//
//  A000040.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A000040

    Generates the prime numbers. A prime number is only divisible by 1 and itself.

    First 10 elements:
  
      2, 3, 5, 7, 11, 13, 17, 19, 23, 29
*/
open class A000040: RecursiveS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA000040, description: "Prime numbers",
      nextElement: {
        if $0 == 0 { return 2 }
        var k = $1[$0-1] + 1
        while factorize(k).count != 1 { k = k + 1 }
        return k
      }
    )
  }
}
