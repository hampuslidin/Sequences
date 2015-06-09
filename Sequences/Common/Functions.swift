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
public func factorize<T: IntegerType>(n: T) -> [T] {
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