//
//  Operators.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

// MARK: Add
public func +    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: +)
}

public func +    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs + RecurringS(number: rhs)
}

public func +    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return rhs + lhs
}

// MARK: Subtract
public func -    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: -)
}

public func -    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs - RecurringS(number: rhs)
}

public func -    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return RecurringS(number: lhs) - rhs
}

// MARK: Multiply
public func *    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: *)
}

public func *    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs * RecurringS(number: rhs)
}

public func *    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return rhs * lhs
}

// MARK: Divide
public func /    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: /)
}

public func /    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs / RecurringS(number: rhs)
}

public func /    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return RecurringS(number: lhs) / rhs
}

// MARK: Modulus
public func %    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: %)
}

public func %    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs % RecurringS(number: rhs)
}

public func %    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return RecurringS(number: lhs) % rhs
}

// MARK: Logical left shift
public func <<   <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: <<)
}

public func <<   <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs << RecurringS(number: rhs)
}

public func <<   <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return RecurringS(number: lhs) << rhs
}

// MARK: Logical right shift
public func >>   <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: >>)
}

public func >>   <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs >> RecurringS(number: rhs)
}

public func >>   <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return RecurringS(number: lhs) >> rhs
}

// MARK: Bitwise AND
public func &    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: &)
}

public func &    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs & RecurringS(number: rhs)
}

public func &    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return rhs & lhs
}

// MARK: Bitwise OR
func |    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: |)
}

func |    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs | RecurringS(number: rhs)
}

func |    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return rhs | lhs
}

// MARK: Bitwise XOR
func ^    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element == LInt, T1.Index == Int,
          T2.Generator.Element == LInt, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: ^)
}

func ^    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: T, rhs: U) -> CombinedS {
  return lhs ^ RecurringS(number: rhs)
}

func ^    <T: IntegerSType, U: IntegerType
    where T.Generator.Element == LInt, T.Index == Int>
    (lhs: U, rhs: T) -> CombinedS {
  return rhs ^ lhs
}

// MARK: Bitwaise NOT
prefix func ~    <T: IntegerSType where T.Generator.Element == LInt, T.Index == Int>
    (seq: T) -> CombinedS {
  return CombinedS(lhs: seq, rhs: RecurringS(number: 0)) { a1, a2 in ~a1 }
}
