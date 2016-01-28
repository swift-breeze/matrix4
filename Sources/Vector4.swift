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


public struct Vector4<T:ArithmeticType> : VectorType {

    public typealias Element = T

    public var x:T, y:T, z:T, w:T

    public var r:T { get {return x} set {x = newValue} }
    public var g:T { get {return y} set {y = newValue} }
    public var b:T { get {return z} set {z = newValue} }
    public var a:T { get {return w} set {w = newValue} }

    public var startIndex: Int { return 0 }
    public var endIndex: Int { return 4 }

    public subscript(index: Int) -> T {
        get {

            switch(index) {
            case 0: return x
            case 1: return y
            case 2: return z
            case 3: return w
            default: preconditionFailure("Vector index out of range")
            }
        }
        set {
            switch(index) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            case 3: w = newValue
            default: preconditionFailure("Vector index out of range")
            }
        }
    }

    public var debugDescription: String {
        return String(self.dynamicType) + "(\(x), \(y), \(z), \(w))"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue, z.hashValue, w.hashValue)
    }

    public init () {
        self.x = 0
        self.y = 0
        self.z = 0
        self.w = 0
    }

    public init (_ v:T) {
        self.x = v
        self.y = v
        self.z = v
        self.w = v
    }

    public init(_ array:[T]) {
        precondition(array.count == 4, "Vector4 requires a 4-element array")
        self.x = array[0]
        self.y = array[1]
        self.z = array[2]
        self.w = array[3]
    }

    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }

    public init (_ x:T, _ y:T, _ z:T, _ w:T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (x:T, y:T, z:T, w:T) {
        self.x = x
        self.y = y
        self.z = z
        self.w = w
    }

    public init (r:T, g:T, b:T, a:T) {
        self.x = r
        self.y = g
        self.z = b
        self.w = a
    }

    public init (_ v:Vector4<T>, @noescape _ op:(_:T) -> T) {
        self.x = op(v.x)
        self.y = op(v.y)
        self.z = op(v.z)
        self.w = op(v.w)
    }

    public init (_ s:T, _ v:Vector4<T>, @noescape _ op:(_:T, _:T) -> T) {
        self.x = op(s, v.x)
        self.y = op(s, v.y)
        self.z = op(s, v.z)
        self.w = op(s, v.w)
    }

    public init (_ v:Vector4<T>, _ s:T, @noescape _ op:(_:T, _:T) -> T) {
        self.x = op(v.x, s)
        self.y = op(v.y, s)
        self.z = op(v.z, s)
        self.w = op(v.w, s)
    }

    public init (_ v1:Vector4<T>, _ v2:Vector4<T>, @noescape _ op:(_:T, _:T) -> T) {
        self.x = op(v1.x, v2.x)
        self.y = op(v1.y, v2.y)
        self.z = op(v1.z, v2.z)
        self.w = op(v1.w, v2.w)
    }

    public init (_ v1:Vector4<T>, _ v2:Vector4<T>, _ v3:Vector4<T>, @noescape _ op:(_:T, _:T, _:T) -> T) {
        self.x = op(v1.x, v2.x, v3.x)
        self.y = op(v1.y, v2.y, v3.y)
        self.z = op(v1.z, v2.z, v3.z)
        self.w = op(v1.w, v2.w, v3.w)
    }

    public init (_ v:Vector4<Double>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Float>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Float80>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Int>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<UInt>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Int8>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<UInt8>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Int16>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<UInt16>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Int32>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<UInt32>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<Int64>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public init (_ v:Vector4<UInt64>) {
        self.x = T(v.x)
        self.y = T(v.y)
        self.z = T(v.z)
        self.w = T(v.w)
    }

    public var xy:Vector2<T> { get { return Vector2<T>(x,y) } set { x = newValue.x; y = newValue.y } }
    public var xyz:Vector3<T> { get { return Vector3<T>(x,y,z) } set { x = newValue.x; y = newValue.y; z = newValue.z } }
    public var xyzw:Vector4<T> { get { return Vector4<T>(x,y,z,w) } set { x = newValue.x; y = newValue.y; z = newValue.z; w = newValue.w } }
    public var xyw:Vector3<T> { get { return Vector3<T>(x,y,w) } set { x = newValue.x; y = newValue.y; w = newValue.z } }
    public var xywz:Vector4<T> { get { return Vector4<T>(x,y,w,z) } set { x = newValue.x; y = newValue.y; w = newValue.z; z = newValue.w } }
    public var xz:Vector2<T> { get { return Vector2<T>(x,z) } set { x = newValue.x; z = newValue.y } }
    public var xzy:Vector3<T> { get { return Vector3<T>(x,z,y) } set { x = newValue.x; z = newValue.y; y = newValue.z } }
    public var xzyw:Vector4<T> { get { return Vector4<T>(x,z,y,w) } set { x = newValue.x; z = newValue.y; y = newValue.z; w = newValue.w } }
    public var xzw:Vector3<T> { get { return Vector3<T>(x,z,w) } set { x = newValue.x; z = newValue.y; w = newValue.z } }
    public var xzwy:Vector4<T> { get { return Vector4<T>(x,z,w,y) } set { x = newValue.x; z = newValue.y; w = newValue.z; y = newValue.w } }
    public var xw:Vector2<T> { get { return Vector2<T>(x,w) } set { x = newValue.x; w = newValue.y } }
    public var xwy:Vector3<T> { get { return Vector3<T>(x,w,y) } set { x = newValue.x; w = newValue.y; y = newValue.z } }
    public var xwyz:Vector4<T> { get { return Vector4<T>(x,w,y,z) } set { x = newValue.x; w = newValue.y; y = newValue.z; z = newValue.w } }
    public var xwz:Vector3<T> { get { return Vector3<T>(x,w,z) } set { x = newValue.x; w = newValue.y; z = newValue.z } }
    public var xwzy:Vector4<T> { get { return Vector4<T>(x,w,z,y) } set { x = newValue.x; w = newValue.y; z = newValue.z; y = newValue.w } }
    public var yx:Vector2<T> { get { return Vector2<T>(y,x) } set { y = newValue.x; x = newValue.y } }
    public var yxz:Vector3<T> { get { return Vector3<T>(y,x,z) } set { y = newValue.x; x = newValue.y; z = newValue.z } }
    public var yxzw:Vector4<T> { get { return Vector4<T>(y,x,z,w) } set { y = newValue.x; x = newValue.y; z = newValue.z; w = newValue.w } }
    public var yxw:Vector3<T> { get { return Vector3<T>(y,x,w) } set { y = newValue.x; x = newValue.y; w = newValue.z } }
    public var yxwz:Vector4<T> { get { return Vector4<T>(y,x,w,z) } set { y = newValue.x; x = newValue.y; w = newValue.z; z = newValue.w } }
    public var yz:Vector2<T> { get { return Vector2<T>(y,z) } set { y = newValue.x; z = newValue.y } }
    public var yzx:Vector3<T> { get { return Vector3<T>(y,z,x) } set { y = newValue.x; z = newValue.y; x = newValue.z } }
    public var yzxw:Vector4<T> { get { return Vector4<T>(y,z,x,w) } set { y = newValue.x; z = newValue.y; x = newValue.z; w = newValue.w } }
    public var yzw:Vector3<T> { get { return Vector3<T>(y,z,w) } set { y = newValue.x; z = newValue.y; w = newValue.z } }
    public var yzwx:Vector4<T> { get { return Vector4<T>(y,z,w,x) } set { y = newValue.x; z = newValue.y; w = newValue.z; x = newValue.w } }
    public var yw:Vector2<T> { get { return Vector2<T>(y,w) } set { y = newValue.x; w = newValue.y } }
    public var ywx:Vector3<T> { get { return Vector3<T>(y,w,x) } set { y = newValue.x; w = newValue.y; x = newValue.z } }
    public var ywxz:Vector4<T> { get { return Vector4<T>(y,w,x,z) } set { y = newValue.x; w = newValue.y; x = newValue.z; z = newValue.w } }
    public var ywz:Vector3<T> { get { return Vector3<T>(y,w,z) } set { y = newValue.x; w = newValue.y; z = newValue.z } }
    public var ywzx:Vector4<T> { get { return Vector4<T>(y,w,z,x) } set { y = newValue.x; w = newValue.y; z = newValue.z; x = newValue.w } }
    public var zx:Vector2<T> { get { return Vector2<T>(z,x) } set { z = newValue.x; x = newValue.y } }
    public var zxy:Vector3<T> { get { return Vector3<T>(z,x,y) } set { z = newValue.x; x = newValue.y; y = newValue.z } }
    public var zxyw:Vector4<T> { get { return Vector4<T>(z,x,y,w) } set { z = newValue.x; x = newValue.y; y = newValue.z; w = newValue.w } }
    public var zxw:Vector3<T> { get { return Vector3<T>(z,x,w) } set { z = newValue.x; x = newValue.y; w = newValue.z } }
    public var zxwy:Vector4<T> { get { return Vector4<T>(z,x,w,y) } set { z = newValue.x; x = newValue.y; w = newValue.z; y = newValue.w } }
    public var zy:Vector2<T> { get { return Vector2<T>(z,y) } set { z = newValue.x; y = newValue.y } }
    public var zyx:Vector3<T> { get { return Vector3<T>(z,y,x) } set { z = newValue.x; y = newValue.y; x = newValue.z } }
    public var zyxw:Vector4<T> { get { return Vector4<T>(z,y,x,w) } set { z = newValue.x; y = newValue.y; x = newValue.z; w = newValue.w } }
    public var zyw:Vector3<T> { get { return Vector3<T>(z,y,w) } set { z = newValue.x; y = newValue.y; w = newValue.z } }
    public var zywx:Vector4<T> { get { return Vector4<T>(z,y,w,x) } set { z = newValue.x; y = newValue.y; w = newValue.z; x = newValue.w } }
    public var zw:Vector2<T> { get { return Vector2<T>(z,w) } set { z = newValue.x; w = newValue.y } }
    public var zwx:Vector3<T> { get { return Vector3<T>(z,w,x) } set { z = newValue.x; w = newValue.y; x = newValue.z } }
    public var zwxy:Vector4<T> { get { return Vector4<T>(z,w,x,y) } set { z = newValue.x; w = newValue.y; x = newValue.z; y = newValue.w } }
    public var zwy:Vector3<T> { get { return Vector3<T>(z,w,y) } set { z = newValue.x; w = newValue.y; y = newValue.z } }
    public var zwyx:Vector4<T> { get { return Vector4<T>(z,w,y,x) } set { z = newValue.x; w = newValue.y; y = newValue.z; x = newValue.w } }
    public var wx:Vector2<T> { get { return Vector2<T>(w,x) } set { w = newValue.x; x = newValue.y } }
    public var wxy:Vector3<T> { get { return Vector3<T>(w,x,y) } set { w = newValue.x; x = newValue.y; y = newValue.z } }
    public var wxyz:Vector4<T> { get { return Vector4<T>(w,x,y,z) } set { w = newValue.x; x = newValue.y; y = newValue.z; z = newValue.w } }
    public var wxz:Vector3<T> { get { return Vector3<T>(w,x,z) } set { w = newValue.x; x = newValue.y; z = newValue.z } }
    public var wxzy:Vector4<T> { get { return Vector4<T>(w,x,z,y) } set { w = newValue.x; x = newValue.y; z = newValue.z; y = newValue.w } }
    public var wy:Vector2<T> { get { return Vector2<T>(w,y) } set { w = newValue.x; y = newValue.y } }
    public var wyx:Vector3<T> { get { return Vector3<T>(w,y,x) } set { w = newValue.x; y = newValue.y; x = newValue.z } }
    public var wyxz:Vector4<T> { get { return Vector4<T>(w,y,x,z) } set { w = newValue.x; y = newValue.y; x = newValue.z; z = newValue.w } }
    public var wyz:Vector3<T> { get { return Vector3<T>(w,y,z) } set { w = newValue.x; y = newValue.y; z = newValue.z } }
    public var wyzx:Vector4<T> { get { return Vector4<T>(w,y,z,x) } set { w = newValue.x; y = newValue.y; z = newValue.z; x = newValue.w } }
    public var wz:Vector2<T> { get { return Vector2<T>(w,z) } set { w = newValue.x; z = newValue.y } }
    public var wzx:Vector3<T> { get { return Vector3<T>(w,z,x) } set { w = newValue.x; z = newValue.y; x = newValue.z } }
    public var wzxy:Vector4<T> { get { return Vector4<T>(w,z,x,y) } set { w = newValue.x; z = newValue.y; x = newValue.z; y = newValue.w } }
    public var wzy:Vector3<T> { get { return Vector3<T>(w,z,y) } set { w = newValue.x; z = newValue.y; y = newValue.z } }
    public var wzyx:Vector4<T> { get { return Vector4<T>(w,z,y,x) } set { w = newValue.x; z = newValue.y; y = newValue.z; x = newValue.w } }
    public var rg:Vector2<T> { get { return Vector2<T>(x,y) } set { x = newValue.x; y = newValue.y } }
    public var rgb:Vector3<T> { get { return Vector3<T>(x,y,z) } set { x = newValue.x; y = newValue.y; z = newValue.z } }
    public var rgba:Vector4<T> { get { return Vector4<T>(x,y,z,w) } set { x = newValue.x; y = newValue.y; z = newValue.z; w = newValue.w } }
    public var rga:Vector3<T> { get { return Vector3<T>(x,y,w) } set { x = newValue.x; y = newValue.y; w = newValue.z } }
    public var rgab:Vector4<T> { get { return Vector4<T>(x,y,w,z) } set { x = newValue.x; y = newValue.y; w = newValue.z; z = newValue.w } }
    public var rb:Vector2<T> { get { return Vector2<T>(x,z) } set { x = newValue.x; z = newValue.y } }
    public var rbg:Vector3<T> { get { return Vector3<T>(x,z,y) } set { x = newValue.x; z = newValue.y; y = newValue.z } }
    public var rbga:Vector4<T> { get { return Vector4<T>(x,z,y,w) } set { x = newValue.x; z = newValue.y; y = newValue.z; w = newValue.w } }
    public var rba:Vector3<T> { get { return Vector3<T>(x,z,w) } set { x = newValue.x; z = newValue.y; w = newValue.z } }
    public var rbag:Vector4<T> { get { return Vector4<T>(x,z,w,y) } set { x = newValue.x; z = newValue.y; w = newValue.z; y = newValue.w } }
    public var ra:Vector2<T> { get { return Vector2<T>(x,w) } set { x = newValue.x; w = newValue.y } }
    public var rag:Vector3<T> { get { return Vector3<T>(x,w,y) } set { x = newValue.x; w = newValue.y; y = newValue.z } }
    public var ragb:Vector4<T> { get { return Vector4<T>(x,w,y,z) } set { x = newValue.x; w = newValue.y; y = newValue.z; z = newValue.w } }
    public var rab:Vector3<T> { get { return Vector3<T>(x,w,z) } set { x = newValue.x; w = newValue.y; z = newValue.z } }
    public var rabg:Vector4<T> { get { return Vector4<T>(x,w,z,y) } set { x = newValue.x; w = newValue.y; z = newValue.z; y = newValue.w } }
    public var gr:Vector2<T> { get { return Vector2<T>(y,x) } set { y = newValue.x; x = newValue.y } }
    public var grb:Vector3<T> { get { return Vector3<T>(y,x,z) } set { y = newValue.x; x = newValue.y; z = newValue.z } }
    public var grba:Vector4<T> { get { return Vector4<T>(y,x,z,w) } set { y = newValue.x; x = newValue.y; z = newValue.z; w = newValue.w } }
    public var gra:Vector3<T> { get { return Vector3<T>(y,x,w) } set { y = newValue.x; x = newValue.y; w = newValue.z } }
    public var grab:Vector4<T> { get { return Vector4<T>(y,x,w,z) } set { y = newValue.x; x = newValue.y; w = newValue.z; z = newValue.w } }
    public var gb:Vector2<T> { get { return Vector2<T>(y,z) } set { y = newValue.x; z = newValue.y } }
    public var gbr:Vector3<T> { get { return Vector3<T>(y,z,x) } set { y = newValue.x; z = newValue.y; x = newValue.z } }
    public var gbra:Vector4<T> { get { return Vector4<T>(y,z,x,w) } set { y = newValue.x; z = newValue.y; x = newValue.z; w = newValue.w } }
    public var gba:Vector3<T> { get { return Vector3<T>(y,z,w) } set { y = newValue.x; z = newValue.y; w = newValue.z } }
    public var gbar:Vector4<T> { get { return Vector4<T>(y,z,w,x) } set { y = newValue.x; z = newValue.y; w = newValue.z; x = newValue.w } }
    public var ga:Vector2<T> { get { return Vector2<T>(y,w) } set { y = newValue.x; w = newValue.y } }
    public var gar:Vector3<T> { get { return Vector3<T>(y,w,x) } set { y = newValue.x; w = newValue.y; x = newValue.z } }
    public var garb:Vector4<T> { get { return Vector4<T>(y,w,x,z) } set { y = newValue.x; w = newValue.y; x = newValue.z; z = newValue.w } }
    public var gab:Vector3<T> { get { return Vector3<T>(y,w,z) } set { y = newValue.x; w = newValue.y; z = newValue.z } }
    public var gabr:Vector4<T> { get { return Vector4<T>(y,w,z,x) } set { y = newValue.x; w = newValue.y; z = newValue.z; x = newValue.w } }
    public var br:Vector2<T> { get { return Vector2<T>(z,x) } set { z = newValue.x; x = newValue.y } }
    public var brg:Vector3<T> { get { return Vector3<T>(z,x,y) } set { z = newValue.x; x = newValue.y; y = newValue.z } }
    public var brga:Vector4<T> { get { return Vector4<T>(z,x,y,w) } set { z = newValue.x; x = newValue.y; y = newValue.z; w = newValue.w } }
    public var bra:Vector3<T> { get { return Vector3<T>(z,x,w) } set { z = newValue.x; x = newValue.y; w = newValue.z } }
    public var brag:Vector4<T> { get { return Vector4<T>(z,x,w,y) } set { z = newValue.x; x = newValue.y; w = newValue.z; y = newValue.w } }
    public var bg:Vector2<T> { get { return Vector2<T>(z,y) } set { z = newValue.x; y = newValue.y } }
    public var bgr:Vector3<T> { get { return Vector3<T>(z,y,x) } set { z = newValue.x; y = newValue.y; x = newValue.z } }
    public var bgra:Vector4<T> { get { return Vector4<T>(z,y,x,w) } set { z = newValue.x; y = newValue.y; x = newValue.z; w = newValue.w } }
    public var bga:Vector3<T> { get { return Vector3<T>(z,y,w) } set { z = newValue.x; y = newValue.y; w = newValue.z } }
    public var bgar:Vector4<T> { get { return Vector4<T>(z,y,w,x) } set { z = newValue.x; y = newValue.y; w = newValue.z; x = newValue.w } }
    public var ba:Vector2<T> { get { return Vector2<T>(z,w) } set { z = newValue.x; w = newValue.y } }
    public var bar:Vector3<T> { get { return Vector3<T>(z,w,x) } set { z = newValue.x; w = newValue.y; x = newValue.z } }
    public var barg:Vector4<T> { get { return Vector4<T>(z,w,x,y) } set { z = newValue.x; w = newValue.y; x = newValue.z; y = newValue.w } }
    public var bag:Vector3<T> { get { return Vector3<T>(z,w,y) } set { z = newValue.x; w = newValue.y; y = newValue.z } }
    public var bagr:Vector4<T> { get { return Vector4<T>(z,w,y,x) } set { z = newValue.x; w = newValue.y; y = newValue.z; x = newValue.w } }
    public var ar:Vector2<T> { get { return Vector2<T>(w,x) } set { w = newValue.x; x = newValue.y } }
    public var arg:Vector3<T> { get { return Vector3<T>(w,x,y) } set { w = newValue.x; x = newValue.y; y = newValue.z } }
    public var argb:Vector4<T> { get { return Vector4<T>(w,x,y,z) } set { w = newValue.x; x = newValue.y; y = newValue.z; z = newValue.w } }
    public var arb:Vector3<T> { get { return Vector3<T>(w,x,z) } set { w = newValue.x; x = newValue.y; z = newValue.z } }
    public var arbg:Vector4<T> { get { return Vector4<T>(w,x,z,y) } set { w = newValue.x; x = newValue.y; z = newValue.z; y = newValue.w } }
    public var ag:Vector2<T> { get { return Vector2<T>(w,y) } set { w = newValue.x; y = newValue.y } }
    public var agr:Vector3<T> { get { return Vector3<T>(w,y,x) } set { w = newValue.x; y = newValue.y; x = newValue.z } }
    public var agrb:Vector4<T> { get { return Vector4<T>(w,y,x,z) } set { w = newValue.x; y = newValue.y; x = newValue.z; z = newValue.w } }
    public var agb:Vector3<T> { get { return Vector3<T>(w,y,z) } set { w = newValue.x; y = newValue.y; z = newValue.z } }
    public var agbr:Vector4<T> { get { return Vector4<T>(w,y,z,x) } set { w = newValue.x; y = newValue.y; z = newValue.z; x = newValue.w } }
    public var ab:Vector2<T> { get { return Vector2<T>(w,z) } set { w = newValue.x; z = newValue.y } }
    public var abr:Vector3<T> { get { return Vector3<T>(w,z,x) } set { w = newValue.x; z = newValue.y; x = newValue.z } }
    public var abrg:Vector4<T> { get { return Vector4<T>(w,z,x,y) } set { w = newValue.x; z = newValue.y; x = newValue.z; y = newValue.w } }
    public var abg:Vector3<T> { get { return Vector3<T>(w,z,y) } set { w = newValue.x; z = newValue.y; y = newValue.z } }
    public var abgr:Vector4<T> { get { return Vector4<T>(w,z,y,x) } set { w = newValue.x; z = newValue.y; y = newValue.z; x = newValue.w } }

}


public func ==<T:ArithmeticType>(v1: Vector4<T>, v2: Vector4<T>) -> Bool {
    return v1.x == v2.x && v1.y == v2.y && v1.z == v2.z && v1.w == v2.w
}
