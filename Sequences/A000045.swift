//
//  A000045.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A000045

    Generates the Fibonacci sequence. The next element in the sequence is defined as the
    sum of the previous two.

    First 10 elements:
  
      0, 1, 1, 2, 3, 5, 8, 13, 21, 34
*/
open class A000045: RecursiveS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA000045, description: "Fibonacci sequence",
      nextElement: {
        if $0 == 0 { return 0 }
        if $0 == 1 { return 1 }
        return $1[$0-1] + $1[$0-2]
      }
    )
  }
}
