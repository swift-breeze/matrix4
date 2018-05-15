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


/// Return the absolute value of `x`.

public func abs<T:VectorType>(_ x:T) -> T where
    T.Element:AbsoluteValuable
{
    return T(x, abs)
}

/// Returns the lesser of `x` and `y`.

public func min<T:VectorType>(_ x:T, _ y:T) -> T {
    return T(x, y, min)
}

/// Returns the lesser of `x` and `y`.

public func min<T:VectorType>(_ x:T, _ y:T.Element) -> T {
    return T(x, y, min)
}

/// Returns the greater of `x` and `y`.

public func max<T:VectorType>(_ x:T, _ y:T) -> T {
    return T(x, y, max)
}

/// Returns the greater of `x` and `y`.

public func max<T:VectorType>(_ x:T, _ y:T.Element) -> T {
    return T(x, y, max)
}

/// Each component of the result is the corresponding element of `x` clamped to
/// the range formed by the corresponding elements of `min` and `max`.  Any
/// lanes of `x` that contain NaN will end up with the `min` value.

public func clamp<T:VectorType>(_ x:T, min:T, max:T) -> T {
    return T(x, min, max) {
        (x:T.Element, min:T.Element, max:T.Element) in
        Swift.min(Swift.max(x, min), max)
    }
}

/// Clamp each element of `x` to the range [`min`, max].  If any lane of `x` is
/// NaN, the corresponding lane of the result is `min`.

public func clamp<T:VectorType>(_ x:T, min:T.Element, max:T.Element) -> T {
        return T(x) { Swift.min(Swift.max($0, min), max) }
}

/// Returns -1 if `x < 0`, +1 if `x > 0`, and 0 otherwise (`sign(NaN)` is 0).

public func sign<T:ArithmeticType where T:FloatingPoint>
    (_ x:T) -> T {
        return x < 0 ? -1 : (x > 0 ? 1 : 0)
}

/// Sign of a vector.  Each lane contains -1 if the corresponding lane of `x`
/// is less than zero, +1 if the corresponding lane of `x` is greater than
/// zero, and 0 otherwise.

public func sign<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return T(x, sign)
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.

public func mix<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, _ y:T, t:T) -> T {
        return T(x, y, t) {
            (x:T.Element, y:T.Element, t:T.Element) in
            let t = x * (1 - t)
            return t + y * t
        }
}

/// Linear interpolation between `x` (at `t=0`) and `y` (at `t=1`).  May be
/// used with `t` outside of [0, 1] as well.

public func mix<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, _ y:T, t:T.Element) -> T {
        let inv = 1 - t
        return T(x, y) {$0 * inv + $1 * t}

}

/// Reciprocal.

public func recip<T:ArithmeticType where T:FloatingPoint>
    (_ x:T) -> T {
        return 1/x
}

/// Elementwise reciprocal.

public func recip<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return T(x, recip)
}

/// Reciprocal square root.

public func rsqrt<T:ArithmeticType where T:FloatingPoint>
    (_ x:T) -> T {
        return 1/InternalMatrix4.M4sqrt(x)
}

/// Elementwise reciprocal.

public func rsqrt<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return T(x, rsqrt)
}

/// Alternate name for minimum of two floating-point vectors.

public func fmin<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, _ y:T) -> T {
        return T(x, y, min)
}

/// Alternate name for maximum of two floating-point vectors.

public func fmax<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, _ y:T) -> T {
        return T(x, y, max)
}

/// Each element of the result is the smallest integral value greater than or
/// equal to the corresponding element of the input.

public func ceil<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return T(x, InternalMatrix4.M4ceil)
}

/// Each element of the result is the largest integral value less than or equal
/// to the corresponding element of the input.

public func floor<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return T(x, InternalMatrix4.M4floor)
}

/// Each element of the result is the closest integral value with magnitude
/// less than or equal to that of the corresponding element of the input.

public func trunc<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return T(x, InternalMatrix4.M4trunc)
}


/// `x - floor(x)`, clamped to lie in the range [0,1).  Without this clamp step,
/// the result would be 1.0 when `x` is a very small negative number, which may
/// result in out-of-bounds table accesses in common usage.

public func fract<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        let one_minus_ulp:T.Element
        switch(x) {
        case is Float:
            one_minus_ulp = T.Element(0x1.fffffep-1)
        case is Double:
            one_minus_ulp = T.Element(0x1.fffffffffffffp-1)
        default:
            preconditionFailure()
        }
    return min(x - floor(x), one_minus_ulp)
}

/// Returns 0.0 if `x < edge`, and 1.0 otherwise.

public func step<T:ArithmeticType where T:FloatingPoint>
    (_ x:T, edge: T) -> T {
        return x < edge ? 0 : 1
}

/// 0.0 if `x < edge`, and 1.0 otherwise.

public func step<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, edge: T) -> T {
        return T(x, edge, step)
}

/// 0.0 if `x < edge0`, 1.0 if `x > edge1`, and cubic interpolation between
/// 0 and 1 in the interval [edge0, edge1].

public func smoothstep<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, edge0:T, edge1:T) -> T {
        return T(edge0, edge1, x) { (edge0, edge1, x) in
            var i = x-edge0
            i /= edge1-edge0
            let t = min(max(i, 0), 1)
            i = 3 - 2 * t
            return t * t * i
        }
}

/// Returns the dot product of `x` and `y`.

public func dot<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, _ y:T) -> T.Element {
        let a = T(x, y, *)
        return a.reduce(0) { $0 + ($1 as! T.Element) }
}

/// Projection of `x` onto `y`.

public func project<T:VectorType where T.Element:FloatingPoint>
    (_ x: T, _ y: T) -> T {
    return dot(x,y)/dot(y,y)*y
}

/// Length of `x`, squared.  This is more efficient to compute than the length,
/// so you should use it if you only need to compare lengths to each other.
/// I.e. instead of writing:
///
///   if (length(x) < length(y)) { ... }
///
/// use:
///
///   if (length_squared(x) < length_squared(y)) { ... }
///
/// Doing it this way avoids one or two square roots, which is a fairly costly
/// operation.

public func length_squared<T:VectorType where T.Element:FloatingPoint>
    (_ x: T) -> T.Element {
    return dot(x,x)
}

/// Length (two-norm or "Euclidean norm") of `x`.

public func length<T:VectorType where T.Element:FloatingPoint>
    (_ x: T) -> T.Element {
    return InternalMatrix4.M4sqrt(length_squared(x))
}

/// The one-norm (or "taxicab norm") of `x`.

public func norm_one<T:VectorType where T.Element:AbsoluteValuable>
    (_ x:T) -> T.Element {
        return x.reduce(0) { $0 + abs($1 as! T.Element) }
}

/// The infinity-norm (or "sup norm") of `x`.

public func norm_inf<T:VectorType>
    (_ x: T) -> T.Element where T.Element: AbsoluteValuable {
        return abs(x).max()!
}


/// Distance between `x` and `y`, squared.

public func distance_squared<T:VectorType where T.Element:FloatingPoint>
    (_ x: T, _ y: T) -> T.Element {
        return length_squared(x - y)
}

/// Distance between `x` and `y`.

public func distance<T:VectorType where T.Element:FloatingPoint>
    (_ x: T, _ y: T) -> T.Element {
        return length(x - y)
}


/// Unit vector pointing in the same direction as `x`.

public func normalize<T:VectorType where T.Element:FloatingPoint>
    (_ x:T) -> T {
        return x / length(x)
}

/// `x` reflected through the hyperplane with unit normal vector `n`, passing
/// through the origin.  E.g. if `x` is [1,2,3] and `n` is [0,0,1], the result
/// is [1,2,-3].

public func reflect<T:VectorType where T.Element:FloatingPoint>
    (_ x:T, _ n:T) -> T {
        return x - 2 * dot(n, x) * n
}

/// The refraction direction given unit incident vector `x`, unit surface
/// normal `n`, and index of refraction `eta`.  If the angle between the
/// incident vector and the surface is so small that total internal reflection
/// occurs, zero is returned.

public func refract<T:VectorType where T.Element:FloatingPoint>
    (_ i:T, _ n:T, _ eta:T.Element) -> T {
        let dotni = dot(n, i)
        var k = dotni * dotni
        k = 1 - k
        k = eta * eta * k
        k = 1 - k
        if (k < 0) { return T() }
        let x = eta * dotni + InternalMatrix4.M4sqrt(k)
        let r = x * n
        return eta * i - r
}

/// Interprets two two-dimensional vectors as three-dimensional vectors in the
/// xy-plane and computes their cross product, which lies along the z-axis.

public func cross<T:ArithmeticType>
    (_ x:Vector2<T>, _ y:Vector2<T>) -> Vector3<T> {
    return Vector3<T>(0, 0, x.x * y.y - y.x * x.y)
}

/// Cross-product of two three-dimensional vectors.  The resulting vector is
/// perpendicular to the plane determined by `x` and `y`, with length equal to
/// the oriented area of the parallelogram they determine.

public func cross<T:ArithmeticType>
    (_ x:Vector3<T>, _ y:Vector3<T>) -> Vector3<T> {
    return Vector3<T>(
        x.y * y.z - y.y * x.z,
        x.z * y.x - y.z * x.x,
        x.x * y.y - y.x * x.y
    )
}
