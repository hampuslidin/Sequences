//
//  Functions.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import LargeNumbers

/**
    Calculates the prime factors of `n`.
  
    :param: n               The number to factorize.

    :returns: A list of the prime factors.
*/
func factorize<T: IntegerType>(n: T) -> [T] {
  if n <= 1 { return [] }
  var list = [n]
  _primeFactorsFun(n, 0, &list)
  sort(&list)
  return list
}

private func _primeFactorsFun<T: IntegerType>(n: T, index: Int, inout list: [T]) {
  for var i: T = 2; LInt(i) <= LInt.sqrt(LInt(n)); i++
  {
    if list[index]%i == 0
    {
      list[index] = list[index]/i
      list.append(i)
      _primeFactorsFun(list[index], index, &list)
      _primeFactorsFun(list.last!, list.count-1, &list)
      return
    }
  }
}

/**
    Placeholder function for iterating to `index` in a generator with `size` elements, by
    applying `nextFunc`.
    
    :param: index     The index to iterate to.
    :param: size      The current number of elements in the generator.
    :param: nextFunc  The `next` function of the generator.
    
    :returns: The value at `index`.
*/
func iterateTo<T1: IntegerType, T2: IntegerType>
    (index: T1, size: T1, nextFunc: () -> T2?) -> T2? {
  var k = size
  if index > k {
    while index > k++ { nextFunc() }
  }
  return nextFunc()
}

/**
    Generic function for performing an binary operation on two sequences conforming
    protocol `IntegerSType`, and whose `Generator` has `Element` of type `IntegerType`.
    
    :param: lhs The left hand expression.
    :param: rhs The right hand expression.
    :param: op  The binary operation to perform.
    
    :returns: A `CombinedIntegerSequence` with the results at each corresponding index.

*/
func operate<T1: IntegerSType, T2: IntegerSType
    where T1.Generator.Element: IntegerType, T1.Index == Int,
          T2.Generator.Element: IntegerType, T2.Index == Int>
    (lhs: T1, rhs: T2,op: (LInt, LInt) -> LInt) -> CombinedIntegerSequence {
  var s = CombinedS(lhs)
  s.addOperation(op, seq: rhs)
  return s
}

func equals<T: IntegerSType where T.Generator.Element: IntegerType, T.Index == Int>
    (lhs: T, rhs: T) -> Bool {
  var s = CombinedS(lhs)
  return s.equals(rhs)
}