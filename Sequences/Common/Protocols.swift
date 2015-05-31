//
//  Protocols.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

typealias IntegerSType    = IntegerSequenceType
typealias CombinedSType   = CombinedSequenceType
typealias VariableSType   = VariableSequenceType
typealias ExplicitSType   = ExplicitSequenceType
typealias RecursiveSType  = RecursiveSequenceType
typealias InfiniteSType   = InfiniteSequenceType
typealias FiniteSType     = FiniteSequenceType

protocol IntegerSequenceType: CollectionType {
  typealias ValueType: IntegerType
  typealias Generator: SGeneratorType
  var delegate: IntegerSequenceDelegate? { get }
  var index: Int { get }
  var last: ValueType? { get }
  var description: String { get}
  func printSequence(amount: Int)
}

protocol CombinedSequenceType: IntegerSequenceType {
  init<T: IntegerSType where T.Generator.Element: IntegerType, T.Index == Int>(_ seq: T)
  func equals<T: IntegerSType where T.Generator.Element: IntegerType, T.Index == Int>
    (seq: T) -> Bool
  func addOperation<T: IntegerSType where T.Generator.Element: IntegerType,
    T.Index == Int>(operation: (LInt, LInt) -> LInt, seq: T)
}

protocol VariableSequenceType: IntegerSequenceType {
  var baseNumber: ValueType { get }
  init(number: ValueType)
}

protocol ExplicitSequenceType: IntegerSequenceType {}

protocol RecursiveSequenceType: IntegerSequenceType {
  var elements: [ValueType] { get }
}

protocol InfiniteSequenceType: IntegerSequenceType {}

protocol FiniteSequenceType: IntegerSequenceType {}

protocol SGeneratorType: GeneratorType {
  func convert() -> SGeneratorOf<LInt>
}