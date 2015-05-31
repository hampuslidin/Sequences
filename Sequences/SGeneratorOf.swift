//
//  SGeneratorOf.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

struct SGeneratorOf<T: IntegerType>: SGeneratorType {
  // MARK: - Properties
  typealias Element = T
  var nextElement: (Int) -> T?
  var index: Int = -1
  
  // MARK: - Initializers
  init(_ nextElement: (Int) -> T?) {
    self.nextElement = nextElement
  }
  
  // MARK: - Instance Methods
  mutating func next() -> T? {
    return nextElement(index++)
  }
  
  func convert() -> SGeneratorOf<LInt> {
    return SGeneratorOf<LInt>() { LInt(self.nextElement($0)!) }
  }
}