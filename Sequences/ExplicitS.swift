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
open class ExplicitS: IntegerS {
  // MARK: - Properties
  fileprivate(set) var infinite: Bool = true
  fileprivate var nextElement: (Int) -> LInt?
  override open var last: LInt? {
    get {
      if infinite { return nil }
      var i = 0
      while next(i) != nil { i += 1 }
      super.endIndex = i
      i -= 1
      return elements[i]
    }
  }
  
  // MARK: - Initializers
  convenience init(infinite: Bool,
                   nextElement next: @escaping (Int) -> LInt?) {
    self.init(infinite: infinite, tag: 0xF2, nextElement: next)
  }
  
  convenience init(infinite: Bool,
                   tag: Int,
                   nextElement next: @escaping (Int) -> LInt?) {
    self.init(infinite: infinite, tag: tag,
      description: "Explicitly generated integer sequence", nextElement: next)
  }
  
  init(infinite: Bool, tag: Int, description: String,
      nextElement next: @escaping (Int) -> LInt?) {
    nextElement = next
    super.init()
    super.tag = tag
    super.description = description
    self.infinite = infinite
  }
  
  override open subscript(i: Int) -> LInt {
    let res = next(i)
    assert(res != nil, "Element \(i+1) doesn't exist.")
    return res!
  }
  
  override open subscript(r: Range<Int>) -> [LInt] {
    var res: [LInt] = []
    for i in 0 ..< r.upperBound {
      res.append(self[i])
    }
    return res
  }
  
  override open func makeIterator() -> SGenerator {
    return SGenerator(next)
  }
  
  // MARK: - Sequence generation
  fileprivate func next(_ i: Int) -> LInt? {
    if i <= elements.count-1 { return elements[i] }
    let res = nextElement(i)
    if let defRes = res { elements.append(defRes) }
    return res
  }
}
