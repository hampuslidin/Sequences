//
//  main.swift
//  Sequences
//
//  Author: Hampus Lidin
//

import Darwin
import Foundation
import LargeNumbers

let a = A000002()
a.printSequence(10)
(a+a).printSequence(10)
println()

let b = A000040()
b.printSequence(10)
(b+b).printSequence(10)
println()

let c = A000045()
c.printSequence(10)
(c+c).printSequence(10)
println()

let d = A004718()
d.printSequence(10)
(d+d).printSequence(10)
println()

let e = A181391()
e.printSequence(10)
(e+e).printSequence(10)
println()

let f = A244471()
f.printSequence(10)
(f+f).printSequence(10)
println()

let g = A001057()
g.printSequence(10)
(g+g).printSequence(10)
println()

let h = A056239()
h.printSequence(10)
(h+h).printSequence(10)
println()

let i = A121805()
i.printSequence(10)
(i+i).printSequence(10)
println("Last element: \(i.last!)") // Eventually prints the result
println("Last element: \(i.last!)") // Prints immediately, otherwise something's wrong