//
//  RecursiveS.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    Generates a sequence with a function `g(currentIndex: Int, inout elements: [LInt]) ->
    LInt?`, where indexing starts at 0. The function is *recursive* and is thus dependant
    on previous elements in order to calculate the next.
  
    Elements:
  
      `g(currentIndex: 0)`, `g(currentIndex: 1)`, `g(currentIndex: 2)`, ...
*/
public class RecursiveS: IntegerS, RecursiveSType {
  // MARK: - Properties
  private(set) var infinite: Bool = true
  var nextElement: (Int, [LInt]) -> LInt?
  var index: Int { get { return elements.count-1 } }
  override public var last: LInt? {
    get {
      if infinite { return nil }
      var i = -1
      while next(++i) != nil {}
      super.endIndex = i--
      return elements[i]
    }
  }
  
  // MARK: - Initializers
  convenience init(infinite: Bool, nextElement next: (Int, [LInt]) -> LInt?) {
    self.init(infinite: infinite, tag: 0xF1, nextElement: next)
  }
  
  convenience init(infinite: Bool, tag: Int,
      nextElement next: (Int, [LInt]) -> LInt?) {
    self.init(infinite: infinite, tag: tag,
      description: "Recursively generated integer sequence", nextElement: next)
  }
  
  init(infinite: Bool, tag: Int, description: String,
      nextElement next: (Int, [LInt]) -> LInt?) {
    nextElement = { next($0, $1) }
    super.init()
    super.tag = tag
    super.description = description
    self.infinite = infinite
  }
  
  override public subscript(i: Int) -> LInt {
    IntegerS.iterateTo(i, size: elements.count, nextFunc: next)
    assert(index >= i, "Element \(i+1) doesn't exist.")
    return elements[i]
  }
  
  override public func generate() -> SGenerator { return SGenerator(next) }
  
  // MARK: - Sequence generation
  private func next(i: Int) -> LInt? {
    if i < index { return elements[i] }
    var res = nextElement(i, elements)
    if let defRes = res { elements.append(defRes) }
    return res
  }
}
