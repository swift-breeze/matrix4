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


#if !os(Linux)
import simd
#endif


public struct Matrix2x2<T:ArithmeticType> : MatrixType {
    public func index(after i: Matrix2x2<T>.Index) -> Matrix2x2<T>.Index {
        if i.y == 2 && i.x == 2 {
            return endIndex
        }
        
        if i.x == 2 && i.y < 2 {
            return Index(x: 0, y: i.y + 1)
        }
        
        return Index(x: i.x + 1, y: i.y)
    }
    
    public var startIndex: Matrix2x2<T>.Index { return Index(x: 0, y: 0) }
    
    public var endIndex: Matrix2x2<T>.Index { return Index(x: 3, y: 3) }
    
    public struct Index: Comparable {
        let x: Int
        let y: Int
        
        public static func <(lhs: Index, rhs: Index) -> Bool {
            if lhs.y == rhs.y {
                return lhs.x < rhs.x
            }
            
            return lhs.y < rhs.y
        }
    }
    
    public subscript(position: Index) -> T {
        get {
            return self[position.y][position.x]
        }
        set {
            self[position.y][position.x] = newValue
        }
    }
    public typealias Element = T

    fileprivate var x:Vector2<T>, y:Vector2<T>

    public subscript(column: Int) -> Vector2<T> {
        get {
            switch(column) {
            case 0: return x
            case 1: return y
            default: preconditionFailure("Column index out of range")
            }
        }
        set {
            switch(column) {
            case 0: x = newValue
            case 1: y = newValue
            default: preconditionFailure("Column index out of range")
            }
        }
    }

    public subscript(column:Int, row:Int) -> T {
        return self[column][row]
    }

    public var debugDescription: String {
        return "\(type(of: self))" + "(" + [x,y].map{ (v:Vector2<T>) -> String in
            "[" + [v.x,v.y].map{ (n:T) -> String in "\(n)" }.joined(separator: ", ") + "]"
            }.joined(separator: ", ") + ")"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue)
    }

    public init() {
        self.x = Vector2<T>(1, 0)
        self.y = Vector2<T>(0, 1)
    }

    public init(_ s: T) {
        self.x = Vector2<T>(s, 0)
        self.y = Vector2<T>(0, s)
    }

    public init(_ x: Vector2<T>, _ y: Vector2<T>) {
        self.x = x
        self.y = y
    }

    public init(
        _ x1:T, _ y1:T,
        _ x2:T, _ y2:T
        ) {
            self.x = Vector2<T>(x1, y1)
            self.y = Vector2<T>(x2, y2)
    }

    public init (_ m:Matrix2x2<T>,  _ op:(_:T) -> T) {
        self.x = Vector2<T>(m.x, op)
        self.y = Vector2<T>(m.y, op)
    }

    public init (_ s:T, _ m:Matrix2x2<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(s, m.x, op)
        self.y = Vector2<T>(s, m.y, op)
    }

    public init (_ m:Matrix2x2<T>, _ s:T,  _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m.x, s, op)
        self.y = Vector2<T>(m.y, s, op)
    }

    public init (_ m1:Matrix2x2<T>, _ m2:Matrix2x2<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m1.x, m2.x, op)
        self.y = Vector2<T>(m1.y, m2.y, op)
    }

    public init (_ m1:Matrix2x2<T>, _ m2:Matrix2x2<T>, _ m3:Matrix2x2<T>,  _ op:(_:T, _:T, _:T) -> T) {
        self.x = Vector2<T>(m1.x, m2.x, m3.x, op)
        self.y = Vector2<T>(m1.y, m2.y, m3.y, op)
    }

    public init(_ m: Matrix2x2<Double>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Float>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Float80>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<Int64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public init(_ m: Matrix2x2<UInt64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
    }

    public var inverse:Matrix2x2<T> {
        #if !os(Linux)
            if T.self == Float.self {
                return unsafeBitCast(unsafeBitCast(self, to: float2x2.self).inverse, to: Matrix2x2<T>.self)
            }
            if T.self == Double.self {
                return unsafeBitCast(unsafeBitCast(self, to: double2x2.self).inverse, to: Matrix2x2<T>.self)
            }
        #endif
        let invdet:T = 1 / determinant
        return invdet * Matrix2x2<T>(self.y.y, 0-self.x.y, 0-self.y.x, self.x.x)
    }

    public var determinant:T {
        return self.x.x * self.y.y - self.y.x * self.x.y
    }

    public var transpose:Matrix2x2<T> {
        return Matrix2x2(
            self.x.x, self.y.x,
            self.x.y, self.y.y
        )
    }

    
    public static func ==(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y
    }
    
    
    public static func *(v: Vector2<T>, m: Matrix2x2<T>) -> Vector2<T> {
        #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(v, to: float2.self) * unsafeBitCast(m, to: float2x2.self), to: Vector2<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(v, to: double2.self) * unsafeBitCast(m, to: double2x2.self), to: Vector2<T>.self)
        }
        #endif
        let x:T = v.x * m.x.x + v.y * m.x.y
        let y:T = v.x * m.y.x + v.y * m.y.y
        return Vector2<T>(x,y)
    }
    
    
    public static func *(m: Matrix2x2<T>, v: Vector2<T>) -> Vector2<T> {
        #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m, to: float2x2.self) * unsafeBitCast(v, to: float2.self), to: Vector2<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m, to: double2x2.self) * unsafeBitCast(v, to: double2.self), to: Vector2<T>.self)
        }
        #endif
        return m.x * v.x + m.y * v.y
    }
    
    
    public static func *(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Matrix2x2<T> {
        #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m1, to: float2x2.self) * unsafeBitCast(m2, to: float2x2.self), to: Matrix2x2<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m1, to: double2x2.self) * unsafeBitCast(m2, to: double2x2.self), to: Matrix2x2<T>.self)
        }
        #endif
        var x:Vector2<T> = m1.x * m2.x.x
        x = x + m1.y * m2.x.y
        var y:Vector2<T> = m1.x * m2.y.x
        y = y + m1.y * m2.y.y
        return Matrix2x2<T>(x, y)
    }
    
    
    public static func *(m1: Matrix2x2<T>, m2: Matrix3x2<T>) -> Matrix3x2<T> {
        #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m1, to: float2x2.self) * unsafeBitCast(m2, to: float3x2.self), to: Matrix3x2<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m1, to: double2x2.self) * unsafeBitCast(m2, to: double3x2.self), to: Matrix3x2<T>.self)
        }
        #endif
        var x:Vector2<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        var y:Vector2<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        var z:Vector2<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
        return Matrix3x2<T>(x, y, z)
    }
    
    
    public static func *(m1: Matrix2x2<T>, m2: Matrix4x2<T>) -> Matrix4x2<T> {
        #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m1, to: float2x2.self) * unsafeBitCast(m2, to: float4x2.self), to: Matrix4x2<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m1, to: double2x2.self) * unsafeBitCast(m2, to: double4x2.self), to: Matrix4x2<T>.self)
        }
        #endif
        var x:Vector2<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        var y:Vector2<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        var z:Vector2<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
        var w:Vector2<T> = m1.x * m2[3].x
        w = w + m1.y * m2[3].y
        return Matrix4x2<T>(x, y, z, w)
    }
    
    
    public static func *=( m1: inout Matrix2x2<T>, m2: Matrix2x2<T>) {
        m1 = m1 * m2
    }
    
    
    public static func /(v: Vector2<T>, m: Matrix2x2<T>) -> Vector2<T> {
        return v * m.inverse
    }
    
    
    public static func /(m: Matrix2x2<T>, v: Vector2<T>) -> Vector2<T> {
        return m.inverse * v
    }
    
    
    public static func /(m1: Matrix2x2<T>, m2: Matrix2x2<T>) -> Matrix2x2<T> {
        return m1 * m2.inverse
    }
    
    
    public static func /=( m1: inout Matrix2x2<T>, m2: Matrix2x2<T>) {
        m1 = m1 / m2
    }
}
