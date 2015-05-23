//
//  sequences.swift
//  Sequences
//
//  Created by Hampus Lidin on 2015-05-23.
//  Copyright (c) 2015 Lidin. All rights reserved.
//

import Foundation

/**
    Calculates the Van Eck sequence. The first element is 0, then each new
    element is calculated by looking at the previous element. If the element
    appears for the first time, then the next element is 0. Otherwise the next
    element is the number of elements since that element appeared last time.
    
    Example:
      
      a(0) = 0  - first appearance, thus next element is 0
      a(1) = 0  - appeared 1 element ago, thus next element is 1
      a(2) = 1  - first appearance, thus next element is 0
      a(3) = 0  - appeared 2 elements ago, thus next element is 2
      a(4) = 2  - etc.
      
    First 20 elements:

      0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5, 3

    :param: length    The length of the sequence.

    :returns: The Van Eck sequence.
*/
func vanEck(length: Int) -> [Int]
{
  return genSeq(length)
  {
    var k = $0-1
    while k >= 0 && $1[$0] != $1[k]
    {
      k--
    }
    if k < 0
    {
      $1.append(0)
    } else
    {
      $1.append($0-k)
    }
  }
}

// Helper functions

/**
    Provides a generic sequence calculation body. It handles special case for
    when `length` is 0 or less, whereas an empty list is then returned.

    :param: length    The length of the sequence.
    :param: function  The function to perform on each element.

    :returns: The calculated sequence.
*/
func genSeq(length: Int, function: (Int, inout [Int]) -> ()) -> [Int]
{
  if length <= 0 { return [] }
  var list = [0]
  for i in 0 ..< length-1
  {
    function(i, &list)
  }
  return list
}

/**
    Prints out `seq` and seperates the elements with `delim`.

    :param: seq   The list of integers.
    :param: delim The delimiter.
*/
func printSeq(seq: [Int], delim: String)
{
  var i = seq.count
  for elem in seq
  {
    print(elem)
    if --i > 0
    {
      print(delim)
    }
  }
}

