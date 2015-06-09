//
//  IntegerS.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

public class IntegerS: IntegerSType {
  // MARK: - Properties
  public private(set) var last: LInt? = nil
  public var description: String = "Integer sequence"
  public var tag: Int = 0xF0
  var elements: [LInt] = []
  
  // MARK: - Class methods
  static func iterateTo(index: Int, size: Int, nextFunc: (Int) -> LInt?) {
    var k = size-1
    if index > k {
      while index > k { nextFunc(k++) }
    }
  }
  
  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGenerator
  public let startIndex: Int = 0
  public var endIndex:   Int = 0
  
  public subscript(i: Int) -> LInt { return elements[i] }
  
  public subscript(range: Range<Int>) -> [LInt] {
    var res = [LInt]()
    for i in range {
      res.append(self[i])
    }
    return res
  }
  
  public func generate() -> SGenerator {
    return SGenerator() {
      a1 in return 0
    }
  }
}