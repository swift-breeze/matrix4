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


public struct Matrix2x4<T:ArithmeticType> : MatrixType {
    public func index(after i: Matrix2x4<T>.Index) -> Matrix2x4<T>.Index {
        if i.y == 3 && i.x == 1 {
            return endIndex
        }
        
        if i.x == 1 && i.y < 3 {
            return Index(x: 0, y: i.y + 1)
        }
        
        return Index(x: i.x + 1, y: i.y)
    }
    
    public var startIndex: Matrix2x4<T>.Index { return Index(x: 0, y: 0) }
    
    public var endIndex: Matrix2x4<T>.Index { return Index(x: 2, y: 4) }
    
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

    fileprivate var x:Vector4<T>, y:Vector4<T>

    public subscript(column: Int) -> Vector4<T> {
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
        return String(describing: type(of: self)) + "(" + [x,y].map{ (v:Vector4<T>) -> String in
            "[" + [v.x,v.y,v.z,v.w].map{ (n:T) -> String in String(describing: n) }.joined(separator: ", ") + "]"
            }.joined(separator: ", ") + ")"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue)
    }

    public init() {
        self.x = Vector4<T>(1, 0, 0, 0)
        self.y = Vector4<T>(0, 1, 0, 0)
    }

    public init(_ s: T) {
        self.x = Vector4<T>(s, 0, 0, 0)
        self.y = Vector4<T>(0, s, 0, 0)
    }

    public init(_ x: Vector4<T>, _ y: Vector4<T>) {
        self.x = x
        self.y = y
    }

    public init(
        _ x1:T, _ y1:T, _ z1:T, _ w1:T,
        _ x2:T, _ y2:T, _ z2:T, _ w2:T
        ) {
            self.x = Vector4<T>(x1, y1, z1, w1)
            self.y = Vector4<T>(x2, y2, z2, w2)
    }

    public init (_ m:Matrix2x4<T>,  _ op:(_:T) -> T) {
        self.x = Vector4<T>(m.x, op)
        self.y = Vector4<T>(m.y, op)
    }

    public init (_ s:T, _ m:Matrix2x4<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(s, m.x, op)
        self.y = Vector4<T>(s, m.y, op)
    }

    public init (_ m:Matrix2x4<T>, _ s:T,  _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(m.x, s, op)
        self.y = Vector4<T>(m.y, s, op)
    }

    public init (_ m1:Matrix2x4<T>, _ m2:Matrix2x4<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector4<T>(m1.x, m2.x, op)
        self.y = Vector4<T>(m1.y, m2.y, op)
    }

    public init (_ m1:Matrix2x4<T>, _ m2:Matrix2x4<T>, _ m3:Matrix2x4<T>,  _ op:(_:T, _:T, _:T) -> T) {
        self.x = Vector4<T>(m1.x, m2.x, m3.x, op)
        self.y = Vector4<T>(m1.y, m2.y, m3.y, op)
    }

    public init(_ m: Matrix2x4<Double>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Float>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Float80>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int8>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt8>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int16>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt16>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int32>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt32>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<Int64>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public init(_ m: Matrix2x4<UInt64>) {
        self.x = Vector4<T>(m.x)
        self.y = Vector4<T>(m.y)
    }

    public var transpose:Matrix4x2<T> {
        return Matrix4x2(
            self.x.x, self.y.x,
            self.x.y, self.y.y,
            self.x.z, self.y.z,
            self.x.w, self.y.w
        )
    }

}


public func ==<T:ArithmeticType>(m1: Matrix2x4<T>, m2: Matrix2x4<T>) -> Bool {
    return m1.x == m2.x && m1.y == m2.y
}



public func *<T:ArithmeticType>(v: Vector4<T>, m: Matrix2x4<T>) -> Vector2<T> {
    #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(v, to: float4.self) * unsafeBitCast(m, to: float2x4.self), to: Vector2<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(v, to: double4.self) * unsafeBitCast(m, to: double2x4.self), to: Vector2<T>.self)
        }
    #endif
    var x:T = v.x * m.x.x
        x = x + v.y * m.x.y
        x = x + v.z * m.x.z
        x = x + v.w * m.x.w
    var y:T = v.x * m.y.x
        y = y + v.y * m.y.y
        y = y + v.z * m.y.z
        y = y + v.w * m.y.w
    return Vector2<T>(x,y)
}



public func *<T:ArithmeticType>(m: Matrix2x4<T>, v: Vector2<T>) -> Vector4<T> {
    #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m, to: float2x4.self) * unsafeBitCast(v, to: float2.self), to: Vector4<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m, to: double2x4.self) * unsafeBitCast(v, to: double2.self), to: Vector4<T>.self)
        }
    #endif
    return m.x * v.x + m.y * v.y
}



public func *<T:ArithmeticType>(m1: Matrix2x4<T>, m2: Matrix2x2<T>) -> Matrix2x4<T> {
    #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m1, to: float2x4.self) * unsafeBitCast(m2, to: float2x2.self), to: Matrix2x4<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m1, to: double2x4.self) * unsafeBitCast(m2, to: double2x2.self), to: Matrix2x4<T>.self)
        }
    #endif
    var x:Vector4<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
    var y:Vector4<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
    return Matrix2x4<T>(x, y)
}



public func *<T:ArithmeticType>(m1: Matrix2x4<T>, m2: Matrix3x2<T>) -> Matrix3x4<T> {
    #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m1, to: float2x4.self) * unsafeBitCast(m2, to: float3x2.self), to: Matrix3x4<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m1, to: double2x4.self) * unsafeBitCast(m2, to: double3x2.self), to: Matrix3x4<T>.self)
        }
    #endif
    var x:Vector4<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
    var y:Vector4<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
    var z:Vector4<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
    return Matrix3x4<T>(x, y, z)
}



public func *<T:ArithmeticType>(m1: Matrix2x4<T>, m2: Matrix4x2<T>) -> Matrix4x4<T> {
    #if !os(Linux)
        if T.self == Float.self {
            return unsafeBitCast(unsafeBitCast(m1, to: float2x4.self) * unsafeBitCast(m2, to: float4x2.self), to: Matrix4x4<T>.self)
        }
        if T.self == Double.self {
            return unsafeBitCast(unsafeBitCast(m1, to: double2x4.self) * unsafeBitCast(m2, to: double4x2.self), to: Matrix4x4<T>.self)
        }
    #endif
    var x:Vector4<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
    var y:Vector4<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
    var z:Vector4<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
    var w:Vector4<T> = m1.x * m2[3].x
        w = w + m1.y * m2[3].y
    return Matrix4x4<T>(x, y, z, w)
}
