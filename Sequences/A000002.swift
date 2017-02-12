//
//  A000002.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A000002

    Generates the Kolakoski sequence. The sequence only contains 1's and 2's,
    and the first element is 1. Each element indicates the length of the runs
    of 1's or 2's that the sequence has produced so far. More formally, a[n]
    is the length of the (n+1)-th run.

    First 10 elements:
  
      1, 2, 2, 1, 1, 2, 1, 2, 2, 1
*/
open class A000002: RecursiveS {
  // MARK: - Initializers
  public init() {
    var runIndex = 0
    
    super.init(infinite: true, tag: 0xA000002, description: "Kolakoski sequence",
      nextElement: {
        if $0 == 0 { return 1 }
        var res: LInt = 0
        if $1[runIndex] == 1 ||
            $1[$0-1] == $1[$0-2] {
          res = $1[$0-1]%2+1
          runIndex += 1
        } else if $1[runIndex] == 2 {
          res = $1[$0-1]
        }
        return res
      }
    )
  }
}
