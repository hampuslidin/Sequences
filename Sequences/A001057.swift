//
//  A001057.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import Darwin
import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A056239

    Generates all the integers.

    First 10 elements:
  
      0, 1, -1, 2, -2, 3, -3, 4, -4, 5
*/
open class A001057: ExplicitS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA001057, description: "All integers",
      nextElement: { 
        let res: LInt = LInt(-($0+1)/2)*LInt(pow(-1.0, Double($0%2)))
        return res
      }
    )
  }
}
