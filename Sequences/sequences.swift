//
//  sequences.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import Darwin
import Foundation
import LargeNumbers

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
func vanEck(length: Int) -> [lint]
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
      $1.append(lint(0))
    } else
    {
      $1.append(lint($0-1-k))
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
func kolakoski(length: Int) -> [lint]
{
  var runIndex = 1
  return genSeq(length)
  {
    if $0 == 0
    {
      $1.append(lint(1))
    } else if $0 == 1
    {
      $1.append(lint(2))
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
func verticalLineDivisible(length: Int) -> [lint]
{
  return genSeq(length)
  {
    if $0 == 0
    {
      $1.append(lint(1))
    } else
    {
      let z: lint = concatenateNumbers($1 as [lint])
      var factors = factorize(z)
      factors = abbreviate(factors, sorted: true)
      factors = factors.filter() {$0 < 10}
      factors.append(lint(1))
      sort(&factors)
      $1.append(_findDivisor(z, factors, $1))
    }
  }
}

// Helper functions

/**
  Calculates the prime factors of `n`.
  
  :param: n               The number to factorize.

  :returns: A list of the prime factors.
*/
func factorize(n: lint) -> [lint]
{
  if n <= 1 { return [] }
  var list = [n]
  _primeFactorsFun(n, 0, &list)
  sort(&list)
  return list
}

private func _primeFactorsFun(n: lint, index: Int,
    inout list: [lint])
{
  for var i = lint(2); i < sqrt(n); i++
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
  Removes any duplicates in an array.
  
  :param: list  The integer array.
*/
func abbreviate(list: [lint], #sorted: Bool) -> [lint]
{
  var arr = list
  if !sorted { sort(&arr) }
  var res = [lint]()
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
func concatenateNumbers(list: [lint]) -> lint
{
  if list.isEmpty { return lint() }
  var z: lint = list[0]
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
func magnitude(n: lint) -> lint
{
  var mag = lint(1)
  while n/(mag*10) != 0 {
    mag *= 10
  }
  return mag
}

private func _findDivisor(z: lint, primeFactors: [lint], seq: [lint])
    -> lint
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

private func _magnify(list: [lint]) -> [lint]
{
  var res: [lint] = []
  for elem in list
  {
    for i in 1 ... 9
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
func member(elem: lint, list: [lint]) -> Bool
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
func split(n: lint) -> (lint, lint) { return (n/10, n%10) }

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
func genSeq(length: Int, function: (Int, inout [lint]) -> ())
    -> [lint]
{
  if length <= 0 { return [] }
  var list = [lint]()
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
func printSeq(seq: [lint], label: String, delim: String)
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