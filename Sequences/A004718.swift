//
//  A004718.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A004718

    Generates Per Nørgård's infinity sequence, where `a[2n] = -a[n]`, `a[2n+1] = a[n] + 1`
    and `a[0] = 0`.

    First 10 elements:
  
      0, 1, -1, 2, 1, 0, -2, 3, -1, 2
*/
public class A004718: RecursiveS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA004718,
      description: "Per Nørgård's infinity sequence", nextElement: {
        if $0 < 0 { return 0 }
        var res: LInt = 0
        if ($0+1)%2 == 0 {
          res = -$1[($0+1)/2]
        } else {
          res = $1[($0)/2] + 1
        }
        return res
      }
    )
  }
}