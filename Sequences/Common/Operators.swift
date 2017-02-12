//
//  Operators.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

// MARK: Add
public func +    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: +)
}

public func +    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs + RecurringS(rhs)
}

public func +    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return rhs + lhs
}

// MARK: Subtract
public func -    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: -)
}

public func -    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs - RecurringS(rhs)
}

public func -    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return RecurringS(lhs) - rhs
}

// MARK: Negate
public prefix func -    <T: IntegerS>(seq: T) -> CombinedS { return 0-seq }

// MARK: Multiply
public func *    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: *)
}

public func *    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs * RecurringS(rhs)
}

public func *    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return rhs * lhs
}

// MARK: Divide
public func /    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: /)
}

public func /    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs / RecurringS(rhs)
}

public func /    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return RecurringS(lhs) / rhs
}

// MARK: Modulus
public func %    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: %)
}

public func %    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs % RecurringS(rhs)
}

public func %    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return RecurringS(lhs) % rhs
}

// MARK: Logical left shift
public func <<   <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: <<)
}

public func <<   <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs << RecurringS(rhs)
}

public func <<   <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return RecurringS(lhs) << rhs
}

// MARK: Logical right shift
public func >>   <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: >>)
}

public func >>   <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs >> RecurringS(rhs)
}

public func >>   <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return RecurringS(lhs) >> rhs
}

// MARK: Bitwise AND
public func &    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: &)
}

public func &    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs & RecurringS(rhs)
}

public func &    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return rhs & lhs
}

// MARK: Bitwise OR
public func |    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: |)
}

public func |    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs | RecurringS(rhs)
}

public func |    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return rhs | lhs
}

// MARK: Bitwise XOR
public func ^    <T: IntegerS>(lhs: T, rhs: T) -> CombinedS {
  return CombinedS(lhs: lhs, rhs: rhs, op: ^)
}

public func ^    <T: IntegerS, U: Integer>(lhs: T, rhs: U) -> CombinedS {
  return lhs ^ RecurringS(rhs)
}

public func ^    <T: IntegerS, U: Integer>(lhs: U, rhs: T) -> CombinedS {
  return rhs ^ lhs
}

// MARK: Bitwise NOT
public prefix func ~    <T: IntegerS>(seq: T) -> CombinedS {
  return CombinedS(lhs: seq, rhs: RecurringS(0)) { a1, a2 in ~a1 }
}
