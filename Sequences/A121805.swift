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
class A121805: FiniteSType, RecursiveSType {
  // MARK: - Properties
  typealias ValueType = Int
  var delegate: IntegerSequenceDelegate? = IntegerSequenceDelegate()
  var index: Int { get { return elements.count-1 } }
  var elements: [Int] = []
  var last: Int? {
    get {
      while next(currentIndex: index) != nil {}
      return elements[index]
    }
  }
  let description = "Commas sequence"
  
  // MARK: - Instance Methods
  func printSequence(amount: Int) {
    delegate?.printSequence(self, amount: amount)
  }

  // MARK: - CollectionType
  typealias Index = Int
  typealias Generator = SGeneratorOf<Int>
  let startIndex: Int = 0
  var endIndex: Int { get { return elements.count } }
  
  subscript(i: Int) -> Int {
    return iterateTo(i, elements.count) { self.next(currentIndex: self.index)! }!
  }
  
  func generate() -> SGeneratorOf<Int> { return SGeneratorOf<Int>(next) }
  
  // MARK: - Sequence generation
  private func next(currentIndex cur_i: Int) -> Int? {
    if cur_i < 0 { elements.append(1); return 1 }
    let posNumbers = possibleNumbers(elements[index])
    for i in 1 ... 9  {
      if msd(posNumbers[i-1]) == i {
        let res = posNumbers[i-1]
        elements.append(res)
        return res
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