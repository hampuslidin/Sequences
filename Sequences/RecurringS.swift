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
open class RecurringS: IntegerS, ExpressibleByIntegerLiteral {
  // MARK: - Properties
  open var baseNumber: LInt {
    didSet {
      description = "Sequence of \(baseNumber)'s"
    }
  }
  
  // MARK: - Initializers
  public required init<T: Integer>(_ number: T) {
    baseNumber = LInt(number)
    super.init()
    tag = 0xF3
  }

  public required convenience init(integerLiteral: IntegerLiteralType) {
    self.init(integerLiteral)
  }
  
  // MARK: CollectionType
  override open subscript(i: Int) -> LInt { return self.baseNumber }
  
  override open subscript(r: Range<Int>) -> [LInt] {
    return [LInt](repeating: self.baseNumber, count: r.count)
  }
  
  override open func makeIterator() -> SGenerator {
    return SGenerator() { a1 in self.baseNumber }
  }
}
