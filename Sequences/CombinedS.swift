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
public class CombinedS: CombinedSType, RecursiveSType {
  // MARK: - Properties
  private var elements: [LInt] = []
  private var index: Int { get { return elements.count-1 } }
  public var lhsGen: SGenerator
  public var rhsGen: SGenerator
  public var op: (LInt, LInt) -> LInt
  public var last: LInt? = nil
  public private(set) var description: String = "Combined sequence"
  public let tag: Int = 0xF4
  
  // MARK: - Initializers
  required public init<T1: IntegerSType, T2: IntegerSType
      where T1.Generator.Element == LInt, T1.Index == Int,
            T2.Generator.Element == LInt, T2.Index == Int>
      (lhs: T1, rhs: T2, op: (LInt, LInt) -> LInt) {
    lhsGen = lhs.generate().convert()
    rhsGen = rhs.generate().convert()
    self.op = op
  }
  
  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGenerator
  public let startIndex: Int = 0
  public var endIndex: Int { get { return elements.count } }
  
  public subscript(i: Int) -> LInt {
    IntegerS.iterateTo(i, size: elements.count, nextFunc: next)
    assert(i >= index, "Element \(i+1) doesn't exist.")
    return elements[i]
  }
  
  public func generate() -> SGenerator {
    return SGenerator() {
      self.next(currentIndex: $0)
    }
  }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> LInt? {
    if cur_i < index { return elements[cur_i+1] }
    var res: LInt = 0
    if let lhs = lhsGen.next() {
      if let rhs = rhsGen.next() {
        last = nil
        var res = op(lhs, rhs)
        elements.append(res)
        return res
      }
    }
    last = elements.last
    return nil
  }
}