//
//  CombinedS.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    Generates a combined sequence of sub-sequences `a` and `b`, with a specified binary
    operation `op` performed on them.

    Elements:
  
      `op(a[0], b[0])`, `op(a[1], b[1])`, `op(a[2], b[2])`, ...
*/
open class CombinedS: IntegerS, ExpressibleByIntegerLiteral {
  // MARK: - Properties
  open fileprivate(set) var infinite: Bool = true
  fileprivate var index: Int { get { return elements.count-1 } }
  open var lhsGen: SGenerator
  open var rhsGen: SGenerator
  open var op: (LInt, LInt) -> LInt
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
  public required init<T: IntegerS>(lhs: T,
                                    rhs: T,
                                    op: @escaping (LInt, LInt) -> LInt) {
    lhsGen = lhs.makeIterator().convert()
    rhsGen = rhs.makeIterator().convert()
    self.op = op
    super.init()
    description = "Combined sequence"
    tag = 0xF4
  }
  
  public required convenience init(integerLiteral: IntegerLiteralType) {
    self.init(lhs: RecurringS(integerLiteral), rhs: 0, op: { a1, a2 in return a1 })
  }
  
  public convenience init<T: IntegerS>(seq: T) {
    self.init(lhs: seq, rhs: RecurringS(0), op: { a1, a2 in return a1 })
  }
  
  // MARK: - CollectionType
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
  
  override open func makeIterator() -> SGenerator {
    return SGenerator() {
      self.next($0)
    }
  }
  
  // MARK: - Sequence generation
  fileprivate func next(_ i: Int) -> LInt? {
    if i <= index { return elements[i] }
    if let lhs = lhsGen.next() {
      if let rhs = rhsGen.next() {
        let res = op(lhs, rhs)
        elements.append(res)
        return res
      }
    }
    infinite = false
    return nil
  }
}
