//
//  sequences.swift
//  Sequences
//

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
func vanEck(length: Int) -> [Int]
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
      $1.append($0-1-k)
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
func kolakoski(length: Int) -> [Int]
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

// Helper functions

/**
    Provides a generic sequence calculation "shell". The body provides an empty
    list, which address is passed to `function`, where the sequence is
    calculated. The shell also handles the special case for when `length` is 0
    or less, whereas an empty list is then returned.

    :param: length    The length of the sequence.
    :param: function  The function to perform on each element.

    :returns: The calculated sequence.
*/
func genSeq(length: Int, function: (Int, inout [Int]) -> ()) -> [Int]
{
  if length <= 0 { return [] }
  var list: [Int] = []
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
func printSeq(seq: [Int], label: String, delim: String)
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
