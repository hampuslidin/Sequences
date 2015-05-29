//
//  A121805.swift
//  Sequences
//
//  Author: Hampus Lidin
//

/**
    © The Online Encyclopedia of Integer Sequences, https://oeis.org/A121805

    Generates the commas sequence. the first element is 1, then subsequent numbers are
    calculated by taking the least significant digit `x` of `a[n]` and concatinate it
    with the most significant digit `y` of `a[n-1]`, forming the number `yx = d`, such
    that `a[n] = a[n-1] + d`.

    First 10 elements:
  
      1, 12, 35, 94, 135, 186, 248, 331, 344, 387
*/
class A121805: FiniteSequenceGenerator, RecursiveSequenceGenerator {
  // Properties
  typealias Element = Int
  var index: Int { get { return elements.count-1 } }
  var elements: [Int] = []
  var last: Int {
    get {
      while next() != nil {}
      return elements[index]
    }
  }
  
  // Class variables
  static let description = "Commas sequence"
  
  // Initializers
  required init() {}
  
  // Functions
  func get(index: Int) -> Int? {
    return iterateTo(index, elements.count) { self.next() }
  }
  
  // Sequence generation
  func next() -> Int? {
    if index < 0 { elements.append(1); return 1 }
    let posNumbers = possibleNumbers(elements[index])
    for i in 1 ... 9  {
      if msd(posNumbers[i-1]) == i {
        elements.append(posNumbers[i-1])
        return elements.last
      }
    }
    return nil
  }
  
  private func possibleNumbers(n: Int) -> [Int] {
    var res: [Int] = []
    for i in 1 ... 9 {
      res.append(n%10*10+i+n)
    }
    return res
  }
  
  private func msd(n: Int) -> Int {
    var res = n
    while res >= 10 { res /= 10 }
    return res
  }
}