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


import XCTest
import Matrix4

private typealias vec2 = Vector2<Float>
private typealias mat2 = Matrix2x2<Float>

class Matrix2x2Tests: XCTestCase {

    func testIdentityInits() {
        let l = mat2()
        let m = mat2(1)
        let x = Float(1)
        XCTAssertEqual(l, m * x)
    }

    func testCommmonInits() {
        let m0 = mat2(
            vec2(0, 1),
            vec2(2, 3)
        )
        let m1 = mat2(0, 1, 2, 3)
        XCTAssertEqual(m0, m1)
    }

    func testDivide() {
        let m = mat2(
            vec2(0, 1),
            vec2(2, 3)
        )
        XCTAssertEqualWithAccuracy(m/m, mat2(), accuracy: 0.000001)
    }

}
