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


public struct Matrix3x2<T:ArithmeticType> : MatrixType {
    public func index(after i: Matrix3x2<T>.Index) -> Matrix3x2<T>.Index {
        if i.y == 2 && i.x == 3 {
            return endIndex
        }
        
        if i.x == 3 && i.y < 2 {
            return Index(x: 0, y: i.y + 1)
        }
        
        return Index(x: i.x + 1, y: i.y)
    }
    
    public var startIndex: Matrix3x2<T>.Index { return Index(x: 0, y: 0) }
    
    public var endIndex: Matrix3x2<T>.Index { return Index(x: 4, y: 3) }
    
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

    fileprivate var x:Vector2<T>, y:Vector2<T>, z:Vector2<T>

    public subscript(column: Int) -> Vector2<T> {
        get {
            switch(column) {
            case 0: return x
            case 1: return y
            case 2: return z
            default: preconditionFailure("Column index out of range")
            }
        }
        set {
            switch(column) {
            case 0: x = newValue
            case 1: y = newValue
            case 2: z = newValue
            default: preconditionFailure("Column index out of range")
            }
        }
    }

    public subscript(column:Int, row:Int) -> T {
        return self[column][row]
    }
    

    public var debugDescription: String {
        return "\(type(of: self))" + "(" + [x,y,z].map{ (v:Vector2<T>) -> String in
            "[" + [v.x,v.y].map{ (n:T) -> String in "\(n)" }.joined(separator: ", ") + "]"
            }.joined(separator: ", ") + ")"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue, z.hashValue)
    }

    public init() {
        self.x = Vector2<T>(1, 0)
        self.y = Vector2<T>(0, 1)
        self.z = Vector2<T>(0, 0)
    }

    public init(_ s: T) {
        self.x = Vector2<T>(s, 0)
        self.y = Vector2<T>(0, s)
        self.z = Vector2<T>(0, 0)
    }

    public init(_ x: Vector2<T>, _ y: Vector2<T>, _ z: Vector2<T>) {
        self.x = x
        self.y = y
        self.z = z
    }

    public init(
        _ x1:T, _ y1:T,
        _ x2:T, _ y2:T,
        _ x3:T, _ y3:T
        ) {
            self.x = Vector2<T>(x1, y1)
            self.y = Vector2<T>(x2, y2)
            self.z = Vector2<T>(x3, y3)
    }

    public init (_ m:Matrix3x2<T>,  _ op:(_:T) -> T) {
        self.x = Vector2<T>(m.x, op)
        self.y = Vector2<T>(m.y, op)
        self.z = Vector2<T>(m.z, op)
    }

    public init (_ s:T, _ m:Matrix3x2<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(s, m.x, op)
        self.y = Vector2<T>(s, m.y, op)
        self.z = Vector2<T>(s, m.z, op)
    }

    public init (_ m:Matrix3x2<T>, _ s:T,  _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m.x, s, op)
        self.y = Vector2<T>(m.y, s, op)
        self.z = Vector2<T>(m.z, s, op)
    }

    public init (_ m1:Matrix3x2<T>, _ m2:Matrix3x2<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector2<T>(m1.x, m2.x, op)
        self.y = Vector2<T>(m1.y, m2.y, op)
        self.z = Vector2<T>(m1.z, m2.z, op)
    }

    public init (_ m1:Matrix3x2<T>, _ m2:Matrix3x2<T>, _ m3:Matrix3x2<T>,  _ op:(_:T, _:T, _:T) -> T) {
        self.x = Vector2<T>(m1.x, m2.x, m3.x, op)
        self.y = Vector2<T>(m1.y, m2.y, m3.y, op)
        self.z = Vector2<T>(m1.z, m2.z, m3.z, op)
    }

    public init(_ m: Matrix3x2<Double>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Float>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Float80>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Int>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<UInt>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Int8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<UInt8>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Int16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<UInt16>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Int32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<UInt32>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<Int64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public init(_ m: Matrix3x2<UInt64>) {
        self.x = Vector2<T>(m.x)
        self.y = Vector2<T>(m.y)
        self.z = Vector2<T>(m.z)
    }

    public var transpose:Matrix2x3<T> {
        return Matrix2x3(
            self.x.x, self.y.x, self.z.x,
            self.x.y, self.y.y, self.z.y
        )
    }
    
    public static func ==<T:ArithmeticType>(m1: Matrix3x2<T>, m2: Matrix3x2<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y && m1.z == m2.z
    }
    

    public static func *<T:ArithmeticType>(v: Vector2<T>, m: Matrix3x2<T>) -> Vector3<T> {
        var x:T = v.x * m.x.x
        x = x + v.y * m.x.y
        var y:T = v.x * m.y.x
        y = y + v.y * m.y.y
        var z:T = v.x * m.z.x
        z = z + v.y * m.z.y
        return Vector3<T>(x,y,z)
    }
    
    
    
    public static func *<T:ArithmeticType>(m: Matrix3x2<T>, v: Vector3<T>) -> Vector2<T> {
        var rv:Vector2<T> = m.x * v.x
        rv = rv + m.y * v.y
        rv = rv + m.z * v.z
        return rv
    }
    
    
    
    public static func *<T:ArithmeticType>(m1: Matrix3x2<T>, m2: Matrix2x3<T>) -> Matrix2x2<T> {
        var x:Vector2<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        x = x + m1.z * m2[0].z
        var y:Vector2<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        y = y + m1.z * m2[1].z
        return Matrix2x2<T>(x, y)
    }
    
    
    
    public static func *<T:ArithmeticType>(m1: Matrix3x2<T>, m2: Matrix3x3<T>) -> Matrix3x2<T> {
        var x:Vector2<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        x = x + m1.z * m2[0].z
        var y:Vector2<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        y = y + m1.z * m2[1].z
        var z:Vector2<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
        z = z + m1.z * m2[2].z
        return Matrix3x2<T>(x, y, z)
    }
    
    
    
    public static func *<T:ArithmeticType>(m1: Matrix3x2<T>, m2: Matrix4x3<T>) -> Matrix4x2<T> {
        var x:Vector2<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        x = x + m1.z * m2[0].z
        var y:Vector2<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        y = y + m1.z * m2[1].z
        var z:Vector2<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
        z = z + m1.z * m2[2].z
        var w:Vector2<T> = m1.x * m2[3].x
        w = w + m1.y * m2[3].y
        w = w + m1.z * m2[3].z
        return Matrix4x2<T>(x, y, z, w)
    }
}



