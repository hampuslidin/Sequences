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
func factorize(n: Int) -> [Int] {
  if n <= 1 { return [] }
  var list = [n]
  _primeFactorsFun(n, 0, &list)
  sort(&list)
  return list
}

private func _primeFactorsFun(n: Int, index: Int, inout list: [Int]) {
  for var i = 2; Double(i) <= sqrt(Double(n)); i++
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
func iterateTo<T: IntegerType, C>(index: T, size: T, nextFunc: () -> C?) -> C? {
  var k = size
  if index > k {
    while index > k++ { nextFunc() }
  }
  return nextFunc()
}