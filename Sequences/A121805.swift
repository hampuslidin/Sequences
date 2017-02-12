//
//  A121805.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A121805

    Generates the commas sequence. the first element is 1, then subsequent numbers are
    calculated by taking the least significant digit `x` of `a[n]` and concatinate it
    with the most significant digit `y` of `a[n-1]`, forming the number `yx = d`, such
    that `a[n] = a[n-1] + d`.

    First 10 elements:
  
      1, 12, 35, 94, 135, 186, 248, 331, 344, 387
*/
open class A121805: RecursiveS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: false, tag: 0xA121805, description: "Commas sequence",
      nextElement: {
        if $0 == 0 { return 1 }
        let posNumbers = A121805.possibleNumbers($1[$0-1])
        for i in 1 ... 9  {
          if A121805.msd(posNumbers[i-1]) == LInt(i) {
            let res = posNumbers[i-1]
            return res
          }
        }
        return nil
      }
    )
  }
  
  // MARK: - Sequence generation
  fileprivate static func possibleNumbers(_ n: LInt) -> [LInt] {
    var res: [LInt] = []
    for i in 1 ... 9 {
      let li = LInt(i)
      res.append((n % 10)*10 + li + n)
    }
    return res
  }
  
  fileprivate static func msd(_ n: LInt) -> LInt {
    var res = n
    while res >= 10 { res /= 10 }
    return res
  }
}
