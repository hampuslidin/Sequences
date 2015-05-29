//
//  BasicSequencePrinter.swift
//  Sequences
//
//  Author: Hampus Lidin
//

class BasicSequencePrinter<G: IntegerSequenceGenerator>: SequencePrinter {
  // Functions
  func printSequence(target: Any, amount: Int) {
    if let cast = target as? IntegerSequence<G> {
      print("\(cast.description): ")
      if amount <= 0 { return }
      for i in 0 ..< amount-1 {
        print("\(cast[i]), ")
      }
      println("\(cast[amount-1])")
    }
  }
}
