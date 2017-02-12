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
public func factorize<T: Integer>(_ n: T) -> [T] {
  if n <= 1 { return [] }
  var list = [n]
  _primeFactorsFun(n, index: 0, list: &list)
  list.sort { $0 < $1 }
  return list
}

private func _primeFactorsFun<T: Integer>(_ n: T, index: Int, list: inout [T]) {
  var i: T = 2
  while LInt(i) <= LInt.sqrt(LInt(n))
  {
    if list[index]%i == 0
    {
      list[index] = list[index]/i
      list.append(i)
      _primeFactorsFun(list[index], index: index, list: &list)
      _primeFactorsFun(list.last!, index: list.count-1, list: &list)
      return
    }
    i = i + 1
  }
}
