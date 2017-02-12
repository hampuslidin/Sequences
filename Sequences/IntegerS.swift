//
//  IntegerS.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

open class IntegerS: Collection {
  // MARK: - Properties
  open var last: LInt? { get { return nil } }
  open internal(set) var description: String = "Integer sequence"
  open internal(set) var tag: Int = 0xF0
  internal var elements: [LInt] = []
  
  // MARK: - Initializers
  public init() {}
  
  // MARK: - Class methods
  static func iterateTo(_ index: Int, size: Int, nextFunc: (Int) -> LInt?) -> LInt? {
    var res: LInt?
    var k = size
    if index > k-1 {
      while index > k-1 {
        res = nextFunc(k)
        k += 1
      }
    }
    return res
  }
  
  // MARK: - CollectionType
  public typealias Index = Int
  public typealias Iterator = SGenerator
  open let startIndex: Int = 0
  open var endIndex:   Int = 0
  
  open subscript(i: Int) -> LInt { return 0 }
  
  public func index(after i: Int) -> Int { return i+1 }
  
  open subscript(range: Range<Int>) -> [LInt] {
    return [LInt](repeating: 0, count: range.count)
  }
  
  open func makeIterator() -> SGenerator {
    return SGenerator() {
      a1 in return 0
    }
  }
}
