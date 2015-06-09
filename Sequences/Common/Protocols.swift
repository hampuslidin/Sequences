//
//  Protocols.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

public protocol IntegerSType: CollectionType {
  typealias Generator: SGeneratorType
  var last: LInt? { get }
  var description: String { get }
  var tag: Int { get }
}

public protocol CombinedSType: IntegerSType {
  var lhsGen: SGenerator { get }
  var rhsGen: SGenerator { get }
  var op: (LInt, LInt) -> LInt { get }
  init<T1: IntegerSType, T2: IntegerSType
      where T1.Generator.Element == LInt, T1.Index == Int,
            T2.Generator.Element == LInt, T2.Index == Int>
      (lhs: T1, rhs: T2, op: (LInt, LInt) -> LInt)
}

public protocol VariableSType: IntegerSType {
  var baseNumber: LInt { get }
  init(number: LInt)
}

public protocol ExplicitSType: IntegerSType {}
public protocol RecursiveSType: IntegerSType {}
public protocol InfiniteSType: IntegerSType {}
public protocol FiniteSType: IntegerSType {}

public protocol SGeneratorType: GeneratorType {
  func convert() -> SGenerator
}
