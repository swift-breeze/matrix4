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


public struct Vector3<T:ArithmeticType> : VectorType {
    public func index(after i: Int) -> Int {
        return i + 1
    }

    public typealias Element = T

    public var x:T, y:T, z:T

    public var r:T { get {return x} set {x = newValue} }
    public var g:T { get {return y} set {y = newValue} }
    public var b:T { get {return z} set {z = newValue} }

    public var startIndex: Int { return 0 }
    public var endIndex: Int { return 4 }

    public subscript(index: Int) -> T {
        get {

            switch(index) {
            case 0: return x
            case 1: return y
            case 2: return z
            default: preconditionFailure("Vector index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: preconditionFailure("Vector index out of range")
            }
        }
    }

    public var debugDescription: String {
        return "\(type(of: self))" + "(\(x), \(y), \(z))"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue, z.hashValue)
    }

    public init () {
        self.x = 0
        self.y = 0
        self.z = 0
    }

    public init (_ v:T) {
        self.x = v
        self.y = v
        self.z = v
    }

    public init(_ array:[T]) {
        precondition(array.count == 3, "Vector3 requires a 3-element array")
        self.x = array[0]
        self.y = array[1]
        self.z = array[2]
    }

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public init (_ x:T, _ y:T, _ z:T) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init (x:T, y:T, z:T) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init (r:T, g:T, b:T) {
        self.x = r
        self.y = g
        self.z = b
    }

    public init (_ v:Vector3<T>,  _ op:(_:T) -> T) {
        self.x = op(v.x)
        self.y = op(v.y)
        self.z = op(v.z)
    }

    public init (_ s:T, _ v:Vector3<T>,  _ op:(_:T, _:T) -> T) {
        self.x = op(s, v.x)
        self.y = op(s, v.y)
        self.z = op(s, v.z)
    }

    public init (_ v:Vector3<T>, _ s:T,  _ op:(_:T, _:T) -> T) {
        self.x = op(v.x, s)
        self.y = op(v.y, s)
        self.z = op(v.z, s)
    }

    public init (_ v1:Vector3<T>, _ v2:Vector3<T>,  _ op:(_:T, _:T) -> T) {
        self.x = op(v1.x, v2.x)
        self.y = op(v1.y, v2.y)
        self.z = op(v1.z, v2.z)
    }

    public init (_ v1:Vector3<T>, _ v2:Vector3<T>, _ v3:Vector3<T>,  _ op:(_:T, _:T, _:T) -> T) {
        self.x = op(v1.x, v2.x, v3.x)
        self.y = op(v1.y, v2.y, v3.y)
        self.z = op(v1.z, v2.z, v3.z)
    }

    public init (_ v:Vector3<T>) {
        self.x = v.x
        self.y = v.y
        self.z = v.z
    }

    public init (_ v:Vector3<Double>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Float>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Float80>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Int>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<UInt>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Int8>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<UInt8>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Int16>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<UInt16>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Int32>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<UInt32>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<Int64>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public init (_ v:Vector3<UInt64>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
    }

    public var xy:Vector2<T> { get { return Vector2<T>(x,y) } set { x = newValue.x; y = newValue.y } }
    public var xyz:Vector3<T> { get { return Vector3<T>(x,y,z) } set { x = newValue.x; y = newValue.y; z = newValue.z } }
    public var xz:Vector2<T> { get { return Vector2<T>(x,z) } set { x = newValue.x; z = newValue.y } }
    public var xzy:Vector3<T> { get { return Vector3<T>(x,z,y) } set { x = newValue.x; z = newValue.y; y = newValue.z } }
    public var yx:Vector2<T> { get { return Vector2<T>(y,x) } set { y = newValue.x; x = newValue.y } }
    public var yxz:Vector3<T> { get { return Vector3<T>(y,x,z) } set { y = newValue.x; x = newValue.y; z = newValue.z } }
    public var yz:Vector2<T> { get { return Vector2<T>(y,z) } set { y = newValue.x; z = newValue.y } }
    public var yzx:Vector3<T> { get { return Vector3<T>(y,z,x) } set { y = newValue.x; z = newValue.y; x = newValue.z } }
    public var zx:Vector2<T> { get { return Vector2<T>(z,x) } set { z = newValue.x; x = newValue.y } }
    public var zxy:Vector3<T> { get { return Vector3<T>(z,x,y) } set { z = newValue.x; x = newValue.y; y = newValue.z } }
    public var zy:Vector2<T> { get { return Vector2<T>(z,y) } set { z = newValue.x; y = newValue.y } }
    public var zyx:Vector3<T> { get { return Vector3<T>(z,y,x) } set { z = newValue.x; y = newValue.y; x = newValue.z } }
    public var rg:Vector2<T> { get { return Vector2<T>(x,y) } set { x = newValue.x; y = newValue.y } }
    public var rgb:Vector3<T> { get { return Vector3<T>(x,y,z) } set { x = newValue.x; y = newValue.y; z = newValue.z } }
    public var rb:Vector2<T> { get { return Vector2<T>(x,z) } set { x = newValue.x; z = newValue.y } }
    public var rbg:Vector3<T> { get { return Vector3<T>(x,z,y) } set { x = newValue.x; z = newValue.y; y = newValue.z } }
    public var gr:Vector2<T> { get { return Vector2<T>(y,x) } set { y = newValue.x; x = newValue.y } }
    public var grb:Vector3<T> { get { return Vector3<T>(y,x,z) } set { y = newValue.x; x = newValue.y; z = newValue.z } }
    public var gb:Vector2<T> { get { return Vector2<T>(y,z) } set { y = newValue.x; z = newValue.y } }
    public var gbr:Vector3<T> { get { return Vector3<T>(y,z,x) } set { y = newValue.x; z = newValue.y; x = newValue.z } }
    public var br:Vector2<T> { get { return Vector2<T>(z,x) } set { z = newValue.x; x = newValue.y } }
    public var brg:Vector3<T> { get { return Vector3<T>(z,x,y) } set { z = newValue.x; x = newValue.y; y = newValue.z } }
    public var bg:Vector2<T> { get { return Vector2<T>(z,y) } set { z = newValue.x; y = newValue.y } }
    public var bgr:Vector3<T> { get { return Vector3<T>(z,y,x) } set { z = newValue.x; y = newValue.y; x = newValue.z } }

    public static func ==(v1: Vector3<T>, v2: Vector3<T>) -> Bool {
        return v1.x == v2.x && v1.y == v2.y && v1.z == v2.z
    }
}



