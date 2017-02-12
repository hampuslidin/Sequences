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
open class RecursiveS: IntegerS {
  // MARK: - Properties
  open fileprivate(set) var infinite: Bool = true
  var nextElement: (Int, [LInt]) -> LInt?
  var index: Int { get { return elements.count-1 } }
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
                   nextElement next: @escaping (Int, [LInt]) -> LInt?) {
    self.init(infinite: infinite, tag: 0xF1, nextElement: next)
  }
  
  convenience init(infinite: Bool,
                   tag: Int,
                   nextElement next: @escaping (Int, [LInt]) -> LInt?) {
    self.init(infinite: infinite, tag: tag,
      description: "Recursively generated integer sequence", nextElement: next)
  }
  
  init(infinite: Bool, tag: Int, description: String,
      nextElement next: @escaping (Int, [LInt]) -> LInt?) {
    nextElement = next
    super.init()
    super.tag = tag
    super.description = description
    self.infinite = infinite
  }

  override open subscript(i: Int) -> LInt {
    if i >= elements.count {
      if let res = IntegerS.iterateTo(i, size: elements.count, nextFunc: next) {
        return res
      } else {
        assert(false, "Element \(i+1) doesn't exist.")
      }
    }
    return elements[i]
  }
  
  override open subscript(r: Range<Int>) -> [LInt] {
    let last = self[r.upperBound-1]
    var res: [LInt] = []
    for i in 0 ..< r.upperBound-1 {
      res.append(self[i])
    }
    res.append(last)
    return res
  }
  
  override open func makeIterator() -> SGenerator { return SGenerator(next) }
  
  // MARK: - Sequence generation
  fileprivate func next(_ i: Int) -> LInt? {
    if i <= index { return elements[i] }
    let res = nextElement(i, elements)
    if let defRes = res { elements.append(defRes) }
    return res
  }
}
