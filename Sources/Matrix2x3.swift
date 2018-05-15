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


public struct Matrix2x3<T:ArithmeticType> : MatrixType {
    
    public func index(after i: Matrix2x3<T>.Index) -> Matrix2x3<T>.Index {
        if i.y == 3 && i.x == 2 {
            return endIndex
        }
        
        if i.x == 2 && i.y < 3 {
            return Index(x: 0, y: i.y + 1)
        }
        
        return Index(x: i.x + 1, y: i.y)
    }
    
    public var startIndex: Matrix2x3<T>.Index { return Index(x: 0, y: 0) }
    
    public var endIndex: Matrix2x3<T>.Index { return Index(x: 3, y: 4) }
    
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

    fileprivate var x:Vector3<T>, y:Vector3<T>

    public subscript(column: Int) -> Vector3<T> {
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
        return "\(type(of: self))" + "(" + [x,y].map{ (v:Vector3<T>) -> String in
            "[" + [v.x,v.y,v.z].map{ (n:T) -> String in "\(n)"}.joined(separator: ", ") + "]"
            }.joined(separator: ", ") + ")"
    }

    public var hashValue: Int {
        return InternalMatrix4.hash(x.hashValue, y.hashValue)
    }

    public init() {
        self.x = Vector3<T>(1, 0, 0)
        self.y = Vector3<T>(0, 1, 0)
    }

    public init(_ s: T) {
        self.x = Vector3<T>(s, 0, 0)
        self.y = Vector3<T>(0, s, 0)
    }

    public init(_ x: Vector3<T>, _ y: Vector3<T>) {
        self.x = x
        self.y = y
    }

    public init(
        _ x1:T, _ y1:T, _ z1:T,
        _ x2:T, _ y2:T, _ z2:T
        ) {
            self.x = Vector3<T>(x1, y1, z1)
            self.y = Vector3<T>(x2, y2, z2)
    }

    public init (_ m:Matrix2x3<T>,  _ op:(_:T) -> T) {
        self.x = Vector3<T>(m.x, op)
        self.y = Vector3<T>(m.y, op)
    }

    public init (_ s:T, _ m:Matrix2x3<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector3<T>(s, m.x, op)
        self.y = Vector3<T>(s, m.y, op)
    }

    public init (_ m:Matrix2x3<T>, _ s:T,  _ op:(_:T, _:T) -> T) {
        self.x = Vector3<T>(m.x, s, op)
        self.y = Vector3<T>(m.y, s, op)
    }

    public init (_ m1:Matrix2x3<T>, _ m2:Matrix2x3<T>,  _ op:(_:T, _:T) -> T) {
        self.x = Vector3<T>(m1.x, m2.x, op)
        self.y = Vector3<T>(m1.y, m2.y, op)
    }

    public init (_ m1:Matrix2x3<T>, _ m2:Matrix2x3<T>, _ m3:Matrix2x3<T>,  _ op:(_:T, _:T, _:T) -> T) {
        self.x = Vector3<T>(m1.x, m2.x, m3.x, op)
        self.y = Vector3<T>(m1.y, m2.y, m3.y, op)
    }

    public init(_ m: Matrix2x3<Double>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Float>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Float80>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Int>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<UInt>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Int8>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<UInt8>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Int16>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<UInt16>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Int32>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<UInt32>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<Int64>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public init(_ m: Matrix2x3<UInt64>) {
        self.x = Vector3<T>(m.x)
        self.y = Vector3<T>(m.y)
    }

    public var transpose:Matrix3x2<T> {
        return Matrix3x2(
            self.x.x, self.y.x,
            self.x.y, self.y.y,
            self.x.z, self.y.z
        )
    }

    public static func ==<T:ArithmeticType>(m1: Matrix2x3<T>, m2: Matrix2x3<T>) -> Bool {
        return m1.x == m2.x && m1.y == m2.y
    }
    
    
    
    public static func *<T:ArithmeticType>(v: Vector3<T>, m: Matrix2x3<T>) -> Vector2<T> {
        var x:T = v.x * m.x.x
        x = x + v.y * m.x.y
        x = x + v.z * m.x.z
        var y:T = v.x * m.y.x
        y = y + v.y * m.y.y
        y = y + v.z * m.y.z
        return Vector2<T>(x,y)
    }
    
    
    
    public static func *<T:ArithmeticType>(m: Matrix2x3<T>, v: Vector2<T>) -> Vector3<T> {
        var rv:Vector3<T> = m.x * v.x
        rv = rv + m.y * v.y
        return rv
    }
    
    
    
    public static func *<T:ArithmeticType>(m1: Matrix2x3<T>, m2: Matrix2x2<T>) -> Matrix2x3<T> {
        var x:Vector3<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        var y:Vector3<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        return Matrix2x3<T>(x, y)
    }
    
    
    
    public static func *<T:ArithmeticType>(m1: Matrix2x3<T>, m2: Matrix3x2<T>) -> Matrix3x3<T> {
        var x:Vector3<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        var y:Vector3<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        var z:Vector3<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
        return Matrix3x3<T>(x, y, z)
    }
    
    
    
    public static func *<T:ArithmeticType>(m1: Matrix2x3<T>, m2: Matrix4x2<T>) -> Matrix4x3<T> {
        var x:Vector3<T> = m1.x * m2[0].x
        x = x + m1.y * m2[0].y
        var y:Vector3<T> = m1.x * m2[1].x
        y = y + m1.y * m2[1].y
        var z:Vector3<T> = m1.x * m2[2].x
        z = z + m1.y * m2[2].y
        var w:Vector3<T> = m1.x * m2[3].x
        w = w + m1.y * m2[3].y
        return Matrix4x3<T>(x, y, z, w)
    }
}



