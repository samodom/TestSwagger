//
//  SampleSpyableTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest

class SampleSpyableTests: XCTestCase {

    static let defaultMessage = "The spyable does not return the correct output"
    var spyableClasses: [AnyClass]!
    var expectedMethodOutput: Int!

    func testRootSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueAtRoot

        XCTAssertEqual(SwiftRootSpyable.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftRootSpyable().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCRootSpyable.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCRootSpyable().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }


    //  Inheriting

    func testInheritorSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueAtRoot

        XCTAssertEqual(SwiftInheritor.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCInheritor.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }

    func testInheritorOfInheritorSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueAtRoot

        XCTAssertEqual(SwiftInheritorOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftInheritorOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCInheritorOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCInheritorOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }


    //  Overriding

    func testOverriderSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueOverridenAtLevel1

        XCTAssertEqual(SwiftOverrider.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCOverrider.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }

    func testOverriderOfOverriderSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueOverridenAtLevel2

        XCTAssertEqual(SwiftOverriderOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftOverriderOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCOverriderOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCOverriderOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }


    //  Hybrid

    func testOverriderOfInheritorSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueOverridenAtLevel2

        XCTAssertEqual(SwiftOverriderOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftOverriderOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCOverriderOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCOverriderOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }

    func testInheritorOfOverriderSpyableMethods() {
        expectedMethodOutput = NormalMethodReturnValueOverridenAtLevel1

        XCTAssertEqual(SwiftInheritorOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(SwiftInheritorOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)

        XCTAssertEqual(ObjectiveCInheritorOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
        XCTAssertEqual(ObjectiveCInheritorOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, SampleSpyableTests.defaultMessage)
    }

}
