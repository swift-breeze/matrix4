// Copyright (c) 2015-2016 David Turnbull
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and/or associated documentation files (the
// "Materials"), to deal in the Materials without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Materials, and to
// permit persons to whom the Materials are furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Materials.
//
// THE MATERIALS ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// MATERIALS OR THE USE OR OTHER DEALINGS IN THE MATERIALS.


public protocol ArithmeticType : Hashable, Comparable, ExpressibleByIntegerLiteral {
    init(_: Double)
    init(_: Float)
    init(_: Float80)
    init(_: Int)
    init(_: UInt)
    init(_: Int8)
    init(_: UInt8)
    init(_: Int16)
    init(_: UInt16)
    init(_: Int32)
    init(_: UInt32)
    init(_: Int64)
    init(_: UInt64)
    static func +(_: Self, _: Self) -> Self
    static func +=( _: inout Self, _: Self)
    static func -(_: Self, _: Self) -> Self
    static func -=( _: inout Self, _: Self)
    static func *(_: Self, _: Self) -> Self
    static func *=( _: inout Self, _: Self)
    static func /(_: Self, _: Self) -> Self
    static func /=( _: inout Self, _: Self)
    static func %(_: Self, _: Self) -> Self
    static func %=( _: inout Self, _: Self)
}
extension Double: ArithmeticType {}
extension Float: ArithmeticType {}
extension Float80: ArithmeticType {}

public protocol IntegerArithmeticType : ArithmeticType {
    static func &+(_: Self, _: Self) -> Self
    static func &-(_: Self, _: Self) -> Self
    static func &*(_: Self, _: Self) -> Self
    static func <<(_: Self, _: Self) -> Self
    static func >>(_: Self, _: Self) -> Self
    static func &(_: Self, _: Self) -> Self
    static func &=( _: inout Self, _: Self)
    static func |(_: Self, _: Self) -> Self
    static func |=( _: inout Self, _: Self)
    static func ^(_: Self, _: Self) -> Self
    static func ^=( _: inout Self, _: Self)
    prefix static func ~(_: Self) -> Self
}
extension Int: IntegerArithmeticType {}
extension UInt: IntegerArithmeticType {}
extension Int8: IntegerArithmeticType {}
extension UInt8: IntegerArithmeticType {}
extension Int16: IntegerArithmeticType {}
extension UInt16: IntegerArithmeticType {}
extension Int32: IntegerArithmeticType {}
extension UInt32: IntegerArithmeticType {}
extension Int64: IntegerArithmeticType {}
extension UInt64: IntegerArithmeticType {}


public protocol MatrixType : MutableCollection, Hashable, CustomDebugStringConvertible where Element: ArithmeticType {
    init()
    init(_: Self,  _:(_:Element) -> Element)
    init(_: Element, _: Self,  _:(_:Element, _:Element) -> Element)
    init(_: Self, _: Element,  _:(_:Element, _:Element) -> Element)
    init(_: Self, _: Self,  _:(_:Element, _:Element) -> Element)
    init(_: Self, _: Self, _: Self,  _:(_:Element, _:Element, _:Element) -> Element)
    static func +(_: Self, _: Self) -> Self
    static func +=( _: inout Self, _: Self)
    static func +(_: Element, _: Self) -> Self
    static func +(_: Self, _: Element) -> Self
    static func +=( _: inout Self, _: Element)
    static func -(_: Self, _: Self) -> Self
    static func -=( _: inout Self, _: Self)
    static func -(_: Element, _: Self) -> Self
    static func -(_: Self, _: Element) -> Self
    static func -=( _: inout Self, _: Element)
    static func *(_: Element, _: Self) -> Self
    static func *(_: Self, _: Element) -> Self
    static func *=( _: inout Self, _: Element)
    static func /(_: Element, _: Self) -> Self
    static func /(_: Self, _: Element) -> Self
    static func /=( _: inout Self, _: Element)
    static func %(_: Self, _: Self) -> Self
    static func %=( _: inout Self, _: Self)
    static func %(_: Element, _: Self) -> Self
    static func %(_: Self, _: Element) -> Self
    static func %=( _: inout Self, _: Element)
}

public protocol VectorType : MatrixType, ExpressibleByArrayLiteral {
    static func *(_: Self, _: Self) -> Self
    static func *=( _: inout Self, _: Self)
    static func /(_: Self, _: Self) -> Self
    static func /=( _: inout Self, _: Self)
}
