//
//  IntegerSequence.swift
//  Sequences
//
//  Author: Hampus Lidin
//

class IntegerSequence<G: IntegerSequenceGenerator>: CollectionType {
  // Properties
  var description: String { get { return G.description } }
  var generator: G = G()
  var delegate: SequencePrinter = BasicSequencePrinter<G>()
  let startIndex: Int = 0
  var endIndex: Int { get { return generator.index + 1 } }
  
  // Initializers
  init() {}
  
  init<T: SequencePrinter>(delegate: T?) {
    self.delegate = delegate ?? BasicSequencePrinter<G>()
  }
  
  // Functions
  func printSequence(amount: Int) {
    delegate.printSequence(self, amount: amount)
  }
    
  // Conformance to protocol
  typealias Index = Int
  typealias Generator = G
  
  subscript(i: Int) -> G.Element {
    return generator.get(i)!
  }
  
  func generate() -> G {
    return G()
  }
}