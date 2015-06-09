//
//  SGeneratorOf.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

public struct SGenerator: SGeneratorType {
  // MARK: - Properties
  var nextElement: (Int) -> LInt?
  var index: Int = -1
  
  // MARK: - Initializers
  init(_ nextElement: (Int) -> LInt?) {
    self.nextElement = nextElement
  }
  
  // MARK: - Instance Methods
  public mutating func next() -> LInt? {
    return nextElement(index++)
  }
  
  public func convert() -> SGenerator {
    return SGenerator() { self.nextElement($0) }
  }
}