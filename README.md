# Matrix4

Matrix4 is a replacement for the simd module that comes with Swift.
Matrix4 implements value types for small vectors and matrices.
Matrix4 is accelerated on supported platforms with SIMD instructions.

To use, include dependency in your `Package.swift`:
```swift
let package = Package(
    dependencies: [
        .Package(url: "https://github.com/swift-breeze/matrix4.git", majorVersion: 1)
    ]
)
```
Then add to your swift program:
```swift
import Matrix4
```

## Why choose this over the simd module?

 * Works on Linux.
 * Use generics and protocols instead of gyb.
 * All element types are supported.
 * Is MutableCollectionType and Hashable.
 * Functional initializers.
 * Packs Vector3 without wasted space.
 * Checked integer operators.
 * Swizzling.
 * Adds rgba element accessors.

## What impact will this have on migrating code?

Struct names have changed. For example, `double2` is `Vector2<Double>`.
Easily migrated with a typealias.

All functions, operators, and initializers from simd have been implemented.
However, everything is now generic so there may be unforeseen circumstances
that need code changes. Also, some functions may be removed in favor of more
modern Swift patterns.

Functions reduce_min, reduce_max, and reduce_add have been removed. Vectors
are MutableCollectionType which provides minElement and maxElement, and a
more powerful reduce.

The llvm SIMD for Vector3 requires the same storage as Vector4. But Vector3 is
heavily used in graphics to store models, normals, and images. It's better to
not waste RAM and blit bandwidth. You can use Vector4 where math performance
is critical. Transforming an array of Vector3 is usually done against a
Matrix4x4 anyways. Under consideration is a build option to choose Vector3
storage but it's not yet known what llvm SIMD looks like on non-x86
architecture.
