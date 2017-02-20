//
//  SpyCoselectorsTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/19/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
@testable import TestSwagger


private extension SwiftRootSpyable {
    dynamic func differentInstanceMethod() -> Void {}
}

class SpyCoselectorsTests: XCTestCase {

    let selector1 = #selector(SwiftRootSpyable.sampleInstanceMethod(_:))
    let selector2 = #selector(SwiftRootSpyable.directSpy_sampleInstanceMethod(_:))

    var coselectors: SpyCoselectors!

    override func setUp() {
        super.setUp()

        coselectors = SpyCoselectors(
            methodType: .instance,
            original: selector1,
            spy: selector2
        )
    }

    func testCoselectorsProperties() {
        XCTAssertEqual(coselectors.methodType, .instance,
                       "The coslectors should keep track of the method type")
        XCTAssertEqual(coselectors.original, #selector(SwiftRootSpyable.sampleInstanceMethod(_:)),
                       "The coslectors should keep track of the original selector")
        XCTAssertEqual(coselectors.spy, #selector(SwiftRootSpyable.directSpy_sampleInstanceMethod(_:)),
                       "The coslectors should keep track of the spy selector")
    }

    func testEquatability() {

        let differentSelector = #selector(SwiftRootSpyable.differentInstanceMethod)

        let differentMethodType = SpyCoselectors(
            methodType: .class,
            original: selector1,
            spy: selector2
        )

        XCTAssertNotEqual(coselectors, differentMethodType,
                          "Coselectors with different method types are unequal")

        let differentOriginalSelector = SpyCoselectors(
            methodType: .instance,
            original: differentSelector,
            spy: selector2
        )

        XCTAssertNotEqual(coselectors, differentOriginalSelector,
                          "Coselectors with different original selectors are unequal")

        let differentSpySelector = SpyCoselectors(
            methodType: .instance,
            original: selector1,
            spy: differentSelector
        )

        XCTAssertNotEqual(coselectors, differentSpySelector,
                          "Coselectors with different spy selectors are unequal")

        let sameCoselectors = SpyCoselectors(
            methodType: .instance,
            original: selector1,
            spy: selector2
        )

        XCTAssertEqual(coselectors, sameCoselectors,
                       "Coselectors with the same method type and matching selectors are equal")
    }

    func testHashability() {
        let expectedHashValue = selector1.hashValue + selector2.hashValue
        XCTAssertEqual(coselectors.hashValue, expectedHashValue,
                       "The hash value should be the sum of the hash values of the two selectors")
    }

}
