//
//  RecurringIntegerSequence.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

typealias RecurringS = RecurringIntegerSequence

class RecurringIntegerSequence: VariableSType, InfiniteSType, ExplicitSType {
  // MARK: - Properties
  typealias ValueType                     = LInt
  var delegate: IntegerSequenceDelegate?  = IntegerSequenceDelegate()
  var baseNumber: LInt                    = 0
  var last: LInt?                         = nil
  let description                         = "Combined sequence"
  var index: Int                          = -1
  
  // MARK: - Initializers
  init() {}
  
  required init<T: IntegerType>(number: T) {
    baseNumber = LInt(number)
  }
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }
  
  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<LInt>
  let startIndex: Int = 0
  var endIndex: Int { get { return index+1 } }
  
  subscript(i: Int) -> LInt {
    index = i
    return self.baseNumber
  }
  
  func generate() -> SGeneratorOf<LInt> {
    return SGeneratorOf<LInt> { a1 in self.baseNumber }
  }
}