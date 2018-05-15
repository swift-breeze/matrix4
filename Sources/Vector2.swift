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


public struct Vector2<T:ArithmeticType> : VectorType {
    public func index(after i: Int) -> Int {
        return i + 1
    }
    
    public typealias Element = T

    public var x:T, y:T

    public var r:T { get {return x} set {x = newValue} }
    public var g:T { get {return y} set {y = newValue} }

    public var startIndex: Int { return 0 }
    public var endIndex: Int { return 2 }

    public subscript(index: Int) -> T {
        get {

            switch(index) {
            case 0: return x
            case 1: return y
            default: preconditionFailure("Vector index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            default: preconditionFailure("Vector index out of range")
            }
        }
    }

    public var debugDescription: String {
        return "\(type(of: self))" + "(\(x), \(y))"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue)
    }

    public init () {
        self.x = 0
        self.y = 0
    }

    public init (_ v:T) {
        self.x = v
        self.y = v
    }

    public init(_ array:[T]) {
        precondition(array.count == 2, "Vector2 requires a 2-element array")
        self.x = array[0]
        self.y = array[1]
    }

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public init (_ x:T, _ y:T) {
        self.x = x
        self.y = y
    }

    public init (x:T, y:T) {
        self.x = x
        self.y = y
    }

    public init (r:T, g:T) {
        self.x = r
        self.y = g
    }

    public init (_ v:Vector2<T>,  _ op:(_:T) -> T) {
        self.x = op(v.x)
        self.y = op(v.y)
    }

    public init (_ s:T, _ v:Vector2<T>,  _ op:(_:T, _:T) -> T) {
        self.x = op(s, v.x)
        self.y = op(s, v.y)
    }

    public init (_ v:Vector2<T>, _ s:T,  _ op:(_:T, _:T) -> T) {
        self.x = op(v.x, s)
        self.y = op(v.y, s)
    }

    public init (_ v1:Vector2<T>, _ v2:Vector2<T>,  _ op:(_:T, _:T) -> T) {
        self.x = op(v1.x, v2.x)
        self.y = op(v1.y, v2.y)
    }

    public init (_ v1:Vector2<T>, _ v2:Vector2<T>, _ v3:Vector2<T>,  _ op:(_:T, _:T, _:T) -> T) {
        self.x = op(v1.x, v2.x, v3.x)
        self.y = op(v1.y, v2.y, v3.y)
    }

    public init (_ v:Vector2<Double>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Float>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Float80>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Int>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<UInt>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Int8>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<UInt8>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Int16>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<UInt16>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Int32>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<UInt32>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<Int64>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public init (_ v:Vector2<UInt64>) {
        self.x = T(v.x)
        self.y = T(v.y)
    }

    public var xy:Vector2<T> { get { return Vector2<T>(x,y) } set { x = newValue.x; y = newValue.y } }
    public var yx:Vector2<T> { get { return Vector2<T>(y,x) } set { y = newValue.x; x = newValue.y } }
    public var rg:Vector2<T> { get { return Vector2<T>(x,y) } set { x = newValue.x; y = newValue.y } }
    public var gr:Vector2<T> { get { return Vector2<T>(y,x) } set { y = newValue.x; x = newValue.y } }

    public static func ==<T:ArithmeticType>(v1: Vector2<T>, v2: Vector2<T>) -> Bool {
        return v1.x == v2.x && v1.y == v2.y
    }
}



