//
//  ExplicitS.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    Generates a sequence with a function `g(currentIndex: Int) -> LInt?`, where indexing
    starts at 0. The function is *explicit* and is thus not dependant on previous
    elements in order to calculate the next.

    Elements:
  
      `g(currentIndex: 0)`, `g(currentIndex: 1)`, `g(currentIndex: 2)`, ...
*/
public class ExplicitS: IntegerS, ExplicitSType {
  // MARK: - Properties
  private(set) var infinite: Bool = true
  private var nextElement: (Int) -> LInt?
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
  convenience init(infinite: Bool, nextElement next: (Int) -> LInt?) {
    self.init(infinite: infinite, tag: 0xF2, nextElement: next)
  }
  
  convenience init(infinite: Bool, tag: Int,
      nextElement next: (Int) -> LInt?) {
    self.init(infinite: infinite, tag: tag,
      description: "Explicitly generated integer sequence", nextElement: next)
  }
  
  init(infinite: Bool, tag: Int, description: String,
      nextElement next: (Int) -> LInt?) {
    nextElement = { next($0) }
    super.init()
    super.tag = tag
    super.description = description
    self.infinite = infinite
  }
  
  override public subscript(i: Int) -> LInt {
    var res = next(i)
    assert(res != nil, "Element \(i+1) doesn't exist.")
    return res!
  }
  
  override public func generate() -> SGenerator {
    return SGenerator(next)
  }
  
  // MARK: - Sequence generation
  private func next(i: Int) -> LInt? {
    if i <= elements.count-1 { return elements[i] }
    var res = nextElement(i)
    if let defRes = res { elements.append(defRes) }
    return res
  }
}