//
//  CombinedIntegerSequence.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

typealias CombinedS = CombinedIntegerSequence

class CombinedIntegerSequence: CombinedSType {
  // MARK: - Properties
  typealias ValueType = LInt
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [LInt] = []
  var gens: [SGeneratorOf<LInt>] = []
  var ops: [(LInt, LInt) -> LInt] = []
  var last: LInt? = nil
  var description = "Combined sequence"
  
  // MARK: - Initializers
  init() {}
  
  required init<T: IntegerSType where T.Generator.Element: IntegerType, T.Index == Int>
      (_ seq: T) {
    gens.append(seq.generate().convert())
    ops.append() { (a1: LInt, a2: LInt) -> LInt in a2 }
  }
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }
  
  func equals<T: IntegerSType where T.Generator.Element: IntegerType, T.Index == Int>
      (seq: T) -> Bool {
    var res = true
    for (i,elem) in enumerate(self) {
      res = res && (seq[i] == elem)
    }
    return res
  }
  
  func addOperation<T: IntegerSType where T.Generator.Element: IntegerType,
      T.Index == Int>(operation: (LInt, LInt) -> LInt, seq: T) {
    gens.append(seq.generate().convert())
    ops.append(operation)
  }
  
  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<LInt>
  let startIndex: Int = 0
  var endIndex: Int { get { return elements.count } }
  
  subscript(i: Int) -> LInt {
    return iterateTo(i, elements.count) { self.next(currentIndex: self.index)! }!
  }
  
  func generate() -> SGeneratorOf<LInt> { return SGeneratorOf<LInt>(next) }
  
  // MARK: - Sequence generation
  // TODO:  Fix bug when printing a `CombinedS`-sequence.
  /**
      **BUG**: When printing a `CombinedS`-sequence, the sequence doesn't start over at a
      new call of `printSequence`, instead it keeps going where it left off previously.
      Example:
  
        let a = A000002()
        a.printSequence(10)
        a.printSequence(10)
        let b = a+a
        (b).printSequence(10)
        (b).printSequence(10)
        (a+a).printSequence(10)
        (a+a).printSequence(10)
  */
  func next(currentIndex cur_i: Int) -> LInt? {
    var res: LInt = 0
    for (i,op) in enumerate(ops) {
      if let next = gens[i].next() {
        res = op(res, next)
      } else { return nil }
    }
    return res
  }
}