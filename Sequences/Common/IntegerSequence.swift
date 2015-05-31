//
//  IntegerSequence.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

class IntegerSequence<G: SequenceGType>: IntegerSequenceType {
  // MARK: - Properties
  var delegate: IntegerSequenceDelegate<G>? = IntegerSequenceDelegate<G>()
  var last: G.Element? { get { return generate().last } }
  var description: String { get { return generate().description } }

  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - Type Methods
  static func operate<C: SequenceGType>
      (lhs: IntegerSequence<C>, rhs: IntegerSequence<C>, op: (LInt, LInt) -> LInt)
        -> CombinedIntegerSequence<CombinedG> {
    var generatorLhs = lhs.generate()
    var s = CombinedIntegerSequence<CombinedG>() {
      return LInt(generatorLhs.next()!) as LInt?
    }
    var generatorRhs = rhs.generate()
    s.generate().addGenerator(op) { return LInt(generatorRhs.next()!) as LInt? }
    return s
  }
  
  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = G
  let startIndex: Int = 0
  var endIndex: Int { get { return generate().index + 1 } }
  
  subscript(i: Int) -> G.Element {
    return generate().get(i)!
  }
  
  func generate() -> G {
    return G()
  }
}