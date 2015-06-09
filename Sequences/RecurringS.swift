//
//  RecurringS.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    Generates a sequence of a recurring number `n`.

    Elements:
  
      `n`, `n`, `n`, ...
*/
public class RecurringS: VariableSType, InfiniteSType, ExplicitSType {
  // MARK: - Properties
  typealias ValueType                     = LInt
  public var baseNumber: LInt
  public var description: String { get { return "Sequence of \(baseNumber)'s" } }
  public let last: LInt?                         = nil
  public let tag: Int = 0xF3
  
  // MARK: - Initializers
  required public init<T: IntegerType>(number: T) {
    baseNumber = LInt(number)
  }
  
  // MARK: - CollectionType
  typealias Index     = Int
  typealias Generator = SGenerator
  public let startIndex: Int = 0
  public var endIndex:   Int = 0
  
  public subscript(i: Int) -> LInt { return self.baseNumber }
  
  public func generate() -> SGenerator {
    return SGenerator() { a1 in self.baseNumber }
  }
}