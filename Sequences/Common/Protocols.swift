//
//  Protocols.swift
//  Sequences
//
//  Created by Hampus Lidin on 2015-05-27.
//  Copyright (c) 2015 Lidin. All rights reserved.
//

/*-------- Generators --------*/
protocol IntegerSequenceGenerator: GeneratorType {
  var index: Int { get }
  static var description: String { get }
  init()
  func get(index: Int) -> Element?
}

protocol ExplicitSequenceGenerator: IntegerSequenceGenerator {}
protocol RecursiveSequenceGenerator: IntegerSequenceGenerator {
  var elements: [Element] { get }
}
protocol InfiniteSequenceGenerator: IntegerSequenceGenerator {}
protocol FiniteSequenceGenerator: IntegerSequenceGenerator {
  var last: Element { get }
}

/*-------- Printer --------*/
protocol SequencePrinter {
  func printSequence(target: Any, amount: Int)
}