//
//  A001477.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, http://oeis.org/A001477

    Generates the non-negative integers.

    First 10 elements:
  
      0, 1, 2, 3, 4, 5, 6, 7, 8, 9
*/
public class A001477: ExplicitS {
  // MARK: - Initializers
  public init() {
    super.init(infinite: true, tag: 0xA001477, description: "Non-negative integers",
      nextElement: { return A000027()[$0]-1 }
    )
  }
}