//
//  BasicSequencePrinter.swift
//  Sequences
//
//  Author: Hampus Lidin
//

typealias IntegerSDelegate = IntegerSequenceDelegate

class IntegerSequenceDelegate {
  func printSequence<T: IntegerSequenceType>(target: T, amount: Int?) {
    print("\(target.description): ")
    if amount != nil && amount! <= 0 { return }
    for (i,elem) in enumerate(target) {
      print("\(elem)")
      if amount != nil && i >= amount!-1 { break }
      print(", ")
    }
    println()
  }
}
