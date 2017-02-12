//
//  A244471.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A244471

    Generates the sequence of integers with the property that if a vertical line
    is drawn between any adjacent pair of digits in the sequence, the number
    formed to the left of the line is divisible by the single digit to the right.
    The sequence contains the smallest numbers that has this property.

    First 20 elements:
  
      1, 11, 3, 7, 71, 31, 111, 113, 33, 117
*/
open class A244471: RecursiveS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA244471,
      description: "Vertical line divisible sequence", nextElement: {
        let factors: [LInt] = [LInt(1),LInt(3),LInt(7),LInt(9)]
        let z = A244471.concatenateNumbers($1)
        let res = A244471.findDivisor(z, factors: factors, seq: $1)
        return res
      }
    )
  }
  
  // MARK: - Sequence generation
  fileprivate static func concatenateNumbers(_ list: [LInt]) -> LInt {
    if list.isEmpty { return 0 }
    var z = list[0]
    for i in 1 ..< list.count {
      z *= magnitude(list[i])*10
      z += list[i]
    }
    return z
  }
        
  fileprivate static func magnitude(_ n: LInt) -> LInt {
    var mag = LInt(1)
    while n/(mag*10) != 0 {
      mag *= 10
    }
    return mag
  }
        
  fileprivate static func findDivisor(_ z: LInt, factors: [LInt], seq: [LInt]) -> LInt {
    var newFactors = [LInt]()
    for elem in factors {
      let (a,b) = split(elem)
      let concat = a != 0 ? concatenateNumbers([z, a]) : z
      if (concat%b == 0) {
        newFactors.append(elem)
        if !member(elem, list: seq) {
          return elem
        }
      }
    }
    return findDivisor(z, factors: magnify(newFactors), seq: seq)
  }
  
  fileprivate static func split(_ n: LInt) -> (LInt, LInt) { return (n/10, n%10) }
  
  fileprivate static func member(_ elem: LInt, list: [LInt]) -> Bool {
    for e in list {
      if e == elem { return true }
    }
    return false
  }
        
  fileprivate static func magnify(_ list: [LInt]) -> [LInt] {
    var res = [LInt]()
    for elem in list {
      res.append(elem*10+1)
      res.append(elem*10+3)
      res.append(elem*10+7)
      res.append(elem*10+9)
    }
    return res
  }
 
}
