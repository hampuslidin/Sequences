//
//  Operators.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

// MARK: Equals
func ==   <T: FiniteSType where T.Generator.Element: IntegerType, T.Index == Int>
    (lhs: T, rhs: T) -> Bool {
  var s = CombinedIntegerSequence(lhs)
  return s.equals(rhs)
}

// MARK: Not equals
func !=   <T: FiniteSType where T.Generator.Element: IntegerType, T.Index == Int>
    (lhs: T, rhs: T) -> Bool {
  return !(lhs == rhs)
}

// MARK: Add
func +    <T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element: IntegerType, T1.Index == Int,
          T2.Generator.Element: IntegerType, T2.Index == Int>
    (lhs: T1, rhs: T2) -> CombinedS {
  return operate(lhs, rhs, +)
}
/*
func +    <G: SequenceGType, T: IntegerType
          where G.Element: IntegerType>
          (lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs.subtract(IntegerSequence<SingleNumberGenerator>(number: rhs))
}

func +    <G: SequenceGType, T: IntegerType
          where G.Element: IntegerType>
          (lhs: T, rhs: IntegerSequence<G>)
            -> IntegerSequence<CombinedGType> {
  return rhs + lhs
}

// MARK: Subtract
func -    <G1, G2: SequenceGType
          where G1.Element: IntegerType, G2.Element: IntegerType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.subtract(rhs)
}

func -    <G: SequenceGType, T: IntegerType
          where G.Element: IntegerType>
          (lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs.subtract(IntegerSequence<SingleNumberGenerator>(number: rhs))
}

func -    <G: SequenceGType, T: IntegerType
          where G.Element: IntegerType>
          (lhs: T, rhs: IntegerSequence<G>)
            -> IntegerSequence<CombinedGType> {
  return rhs - lhs
}

// MARK: Multiply
func *    <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.multiply(rhs)
}

func *    <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs * IntegerSequence<SingleNumberGenerator>()
}

func *    <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs * lhs
}

// MARK: Divide
func /    <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.divide(rhs)
}

func /    <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs / IntegerSequence<SingleNumberGenerator>()
}

func /    <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs / lhs
}

// MARK: Modulus
func %    <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.mod(rhs)
}

func %    <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs % IntegerSequence<SingleNumberGenerator>()
}

func %    <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs % lhs
}

// MARK: Logical left shift
func <<   <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.lls(rhs)
}

func <<   <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs << IntegerSequence<SingleNumberGenerator>()
}

func <<   <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs << lhs
}

// MARK: Logical right shift
func >>   <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.lrs(rhs)
}

func >>   <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs >> IntegerSequence<SingleNumberGenerator>()
}

func >>   <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs >> lhs
}

// MARK: Bitwise AND
func &    <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.and(rhs)
}

func &    <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs & IntegerSequence<SingleNumberGenerator>()
}

func &    <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs & lhs
}

// MARK: Bitwise OR
func |    <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.or(rhs)
}

func |    <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs | IntegerSequence<SingleNumberGenerator>()
}

func |    <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs | lhs
}

// MARK: Bitwise XOR
func ^    <G1: SequenceGType, G2: SequenceGType>
          (lhs: IntegerSequence<G1>, rhs: IntegerSequence<G2>)
            -> IntegerSequence<CombinedGType> {
  return lhs.or(rhs)
}

func ^    <G: SequenceGType, T: IntegerType>(lhs: IntegerSequence<G>, rhs: T)
            -> IntegerSequence<CombinedGType> {
  return lhs | IntegerSequence<SingleNumberGenerator>()
}

func ^    <G: SequenceGType, T: IntegerType>(lhs: T, rhs: IntegerSequence<T>)
            -> IntegerSequence<CombinedGType> {
  return rhs | lhs
}

// MARK: Bitwaise NOT
prefix func ~    <G: SequenceGTypeType>(obj: IntegerSequence<G>)
            -> IntegerSequence<CombinedGType> {
  return IntegerSequence<CombinedGType>() {
    return ~LInt(obj.generator.next()) as LInt?
  }
}
*/