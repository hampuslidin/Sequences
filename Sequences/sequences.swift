//
//  sequences.swift
//  Sequences
//

import Darwin
import Foundation

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A181391

    Calculates the Van Eck sequence. The first element is 0, then each new
    element is calculated by looking at the previous element. If the element
    appears for the first time, then the next element is 0. Otherwise the next
    element is the number of elements since that element appeared last time.

    First 20 elements:

      0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5, 3

    :param: length    The length of the sequence.

    :returns: The Van Eck sequence.
*/
func vanEck(length: Int) -> [UInt64]
{
  return genSeq(length)
  {
    var k = $0-2
    while k >= 0 && $1[$0-1] != $1[k]
    {
      k--
    }
    if k < 0
    {
      $1.append(0)
    } else
    {
      $1.append(UInt64($0-1-k))
    }
  }
}

/**
  © The Online Encyclopedia of Integer Sequences, http://oeis.org/A000002

  Calculates the Kolakoski sequence. The sequence only contains 1's and 2's,
  and the first element is 1. Each element indicates the length of the runs
  of 1's or 2's that the sequence has produced so far. More formally, a(n)
  is the length of the n-th run.

  First 20 elements:
  
    1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2, 1
  
  :param: length    The length of the sequence.

  :returns: The Kolakoski sequence.
*/
func kolakoski(length: Int) -> [UInt64]
{
  var runIndex = 1
  return genSeq(length)
  {
    if $0 == 0
    {
      $1.append(1)
    } else if $0 == 1
    {
      $1.append(2)
    } else
    {
      if $1[runIndex] == 1 || $1[$0-1] == $1[$0-2]
      {
        $1.append($1[$0-1]%2+1)
        runIndex++
      } else if $1[runIndex] == 2
      {
        $1.append($1[$0-1])
      }
    }
  }
}

/**
  © The Online Encyclopedia of Integer Sequences, http://oeis.org/A244471

  Calculates the sequence of integers with the property that if a vertical line
  is drawn between any adjacent pair of digits in the sequence, the number
  formed to the left of the line is divisible by the single digit to the right.
  The sequence contains the smallest numbers that has this property.

  First 20 elements:
  
    1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 2, 1
  
  :param: length    The length of the sequence.

  :returns: The sequence.
*/
func verticalLineDivisible(length: Int) -> [UInt64]
{
  return genSeq(length)
  {
    if $0 == 0
    {
      $1.append(1)
    } else
    {
      let z: UInt64 = concatenateNumbers($1 as [UInt64])
      var factors = factorize(z, 9)
      factors = abbreviate(factors, sorted: true)
      factors = factors.filter() {$0 < 10}
      factors.append(1)
      sort(&factors)
      $1.append(_findDivisor(z, factors, $1))
    }
  }
}

// Helper functions

/**
  Calculates factors of a positive integer, with the option to choose the
  biggest divisor to test the number with. If `maxSizeDivisor` is `nil`, then
  the result will be all the prime factors.
  
  :param: n               The number to factorize.
  :param: maxSizeDivisor  The biggest divisor to test with.
  
  :returns: A list of the factors.
*/
func factorize(n: UInt64, maxSizeDivisor: Int?) -> [UInt64]
{
  if n <= 1 { return [] }
  var list = [n]
  _primeFactorsFun(n, maxSizeDivisor, 0, &list)
  sort(&list)
  return list
}

private func _primeFactorsFun(n: UInt64, maxSizeDivisor: Int?, index: Int,
    inout list: [UInt64])
{
  var limit: UInt64 = 0
  if let defMaxSizePrime = maxSizeDivisor
  {
    limit = UInt64(defMaxSizePrime)
  }
  limit = UInt64(sqrt(Double(n))) < limit ? UInt64(sqrt(Double(n))) : limit
  if limit < 2 { return }
  for i in 2 ... limit
  {
    if list[index]%i == 0
    {
      list[index] = list[index]/i
      list.append(i)
      _primeFactorsFun(list[index], maxSizeDivisor, index, &list)
      _primeFactorsFun(list.last!, maxSizeDivisor, list.count-1, &list)
      return
    }
  }
}

/**
  Removes any duplicates in an array.
  
  :param: list  The integer array.
*/
func abbreviate(list: [UInt64], #sorted: Bool) -> [UInt64]
{
  var arr = list
  if !sorted { sort(&arr) }
  var res = [UInt64]()
  var i = 0
  while i < list.count
  {
    var offs = 1
    while i+offs < list.count && arr[i] == arr[i+offs] { offs++ }
    res.append(arr[i])
    i += offs
  }
  return res
}

/**
  Concatenates the elements of `list` into a single number.
  
  :param: list  The integer array.
  
  :returns: The concatenated number.
*/
func concatenateNumbers(list: [UInt64]) -> UInt64
{
  if list.isEmpty { return 0 }
  var z: UInt64 = list[0]
  for var i = 1; i < list.count; i++
  {
    z *= magnitude(list[i])*10
    z += list[i]
  }
  return z
}

/**
  Calculates the magnitude of an integer.
*/
func magnitude(n: UInt64) -> UInt64
{
  var mag: UInt64 = 1
  while n/(mag*10) != 0 {
    mag *= 10
  }
  return mag
}

private func _findDivisor(z: UInt64, primeFactors: [UInt64], seq: [UInt64])
    -> UInt64
{
  for elem in primeFactors
  {
    let (a,b) = split(elem)
    let concat = a != 0 ? concatenateNumbers([z, a]) : z
    if (b == elem || concat%b == 0) && !member(elem, seq)
    {
      return elem
    }
  }
  return _findDivisor(z, _magnify(primeFactors), seq)
}

private func _magnify(list: [UInt64]) -> [UInt64]
{
  var res: [UInt64] = []
  for elem in list
  {
    for i: UInt64 in 1 ... 9
    {
      res.append(elem*10+i)
    }
  }
  return res
}

/**
  Finds out if `e` is a member of this array.
    
  :param: e The element to look for.
    
  :returns: `true`, if `e` is contained in this array, otherwise `false`
*/
func member(elem: UInt64, list: [UInt64]) -> Bool
{
  for e in list
  {
    if e == elem { return true }
  }
  return false
}

/**
  Splits a number `n` = x_n*10^n+x_(n-1)*10^(n-1)...x_1*10+x_0*1 into two new
  numbers `a` = x_n*10^(n-1)+x_(n-1)*10^(n-2)...x_1*1 and `b` = x_0*1, and returns them
  in a tuple `(a,b)`.

  :param: n The number to split.
    
  :returns: The tuple `(a,b)` of the split number.
*/
func split(n: UInt64) -> (UInt64, UInt64) { return (n/10, n%10) }

// Utility functions

/**
    Provides a generic sequence calculation "shell". The body provides an empty
    list, which address is passed to `function`, where the sequence is
    calculated. The shell also handles the special case for when `length` is 0
    or less, whereas an empty list is then returned.

    :param: length    The length of the sequence.
    :param: function  The function to perform on each element.

    :returns: The calculated sequence.
*/
func genSeq(length: Int, function: (Int, inout [UInt64]) -> ())
    -> [UInt64]
{
  if length <= 0 { return [] }
  var list = [UInt64]()
  for i in 0 ..< length
  {
    function(i, &list)
  }
  return list
}

/**
    Prints out `seq` and seperates the elements with `delim`.

    :param: seq   The list of integers.
    :param: label The text in front of the printed sequence.
    :param: delim The delimiter.
*/
func printSeq(seq: [UInt64], label: String, delim: String)
{
  print(label)
  var i = seq.count
  for elem in seq
  {
    print(elem)
    if --i > 0
    {
      print(delim)
    }
  }
  println()
}
