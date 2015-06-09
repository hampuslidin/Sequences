//
//  A181391.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A181391

    Generates the Van Eck sequence. The first element is 0, then each new
    element is calculated by looking at the previous element. If the element
    appears for the first time, then the next element is 0. Otherwise the next
    element is the number of elements since that element appeared last time.

    First 10 elements:

      0, 0, 1, 0, 2, 0, 2, 2, 1, 6
*/
public class A181391: RecursiveS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA181391, description: "Van Eck sequence",
      nextElement: {
        var k = $0-1, res: LInt = 0
        while k >= 0 && $1.last! != $1[k] {
          k--
        }
        if k < 0 {
          res = 0
        } else {
          res = LInt($0)-LInt(k)
        }
        return res
      }
    )
  }
}