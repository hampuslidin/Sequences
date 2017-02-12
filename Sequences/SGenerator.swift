//
//  SGeneratorOf.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

public struct SGenerator: IteratorProtocol {
  // MARK: - Properties
  var nextElement: (Int) -> LInt?
  var index: Int = 0
  
  // MARK: - Initializers
  init(_ nextElement: @escaping (Int) -> LInt?) {
    self.nextElement = nextElement
  }
  
  // MARK: - Instance Methods
  public mutating func next() -> LInt? {
    index += 1
    return nextElement(index-1)
  }
  
  public func convert() -> SGenerator {
    return SGenerator() { self.nextElement($0) }
  }
}
