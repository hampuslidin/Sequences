//
//  A000027.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A000027

    Generates the positive integers.

    First 10 elements:
  
      1, 2, 3, 4, 5, 6, 7, 8, 9, 10
*/
open class A000027: ExplicitS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA000027, description: "Positive integers",
      nextElement: { LInt($0+1) }
    )
  }
}
