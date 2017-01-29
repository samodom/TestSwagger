//
//  SampleSpyableTests.swift
//  SampleTypes
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes

class SampleSpyableTests: XCTestCase {

    let defaultMessage = "The spyable does not return the correct output"
    var spyableClasses: [AnyClass]!
    var expectedMethodOutput: Int!

    func testSuperclassCallingFlags() {
        func errorMessage(_ class: AnyClass) -> String {
            return "Class \(`class`) should not call its superclass' method"
        }

        XCTAssertFalse(SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass,
                       errorMessage(SwiftOverriderOfInheritor.self))
        XCTAssertFalse(SwiftOverrider.swiftOverriderCallsSuperclass,
                       errorMessage(SwiftOverrider.self))
        XCTAssertFalse(SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass,
                       errorMessage(SwiftOverriderOfOverrider.self))

        XCTAssertFalse(ObjectiveCOverriderOfInheritorCallsSuperclass.boolValue,
                       errorMessage(ObjectiveCOverriderOfInheritor.self))
        XCTAssertFalse(ObjectiveCOverriderCallsSuperclass.boolValue,
                       errorMessage(ObjectiveCOverrider.self))
        XCTAssertFalse(ObjectiveCOverriderOfOverriderCallsSuperclass.boolValue,
                       errorMessage(ObjectiveCOverriderOfOverrider.self))
    }


    // MARK: - Root Spyable

    func testRootSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.definedAtRoot.rawValue

        XCTAssertEqual(SwiftRootSpyable.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftRootSpyable().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCRootSpyable.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCRootSpyable().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }


    //  Inheriting

    func testInheritorSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.definedAtRoot.rawValue

        XCTAssertEqual(SwiftInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }

    func testInheritorOfInheritorSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.definedAtRoot.rawValue

        XCTAssertEqual(SwiftInheritorOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftInheritorOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCInheritorOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCInheritorOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }


    //  Overriding

    func testOverriderSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.overriddenAtLevel1.rawValue

        XCTAssertEqual(SwiftOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }

    func testOverriderSpyableMethodsCallingSuperclass() {
        SwiftOverrider.swiftOverriderCallsSuperclass = true
        ObjectiveCOverriderCallsSuperclass = true
        expectedMethodOutput = WellKnownMethodReturnValues.definedAtRoot.rawValue

        XCTAssertEqual(SwiftOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        SwiftOverrider.swiftOverriderCallsSuperclass = false
        ObjectiveCOverriderCallsSuperclass = false
    }

    func testOverriderOfOverriderSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.overriddenAtLevel2.rawValue

        XCTAssertEqual(SwiftOverriderOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftOverriderOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCOverriderOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCOverriderOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }

    func testOverriderOfOverriderSpyableMethodsCallingSuperclass() {
        SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = true
        ObjectiveCOverriderOfOverriderCallsSuperclass = true
        expectedMethodOutput = WellKnownMethodReturnValues.overriddenAtLevel1.rawValue

        XCTAssertEqual(SwiftOverriderOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftOverriderOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCOverriderOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCOverriderOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = false
        ObjectiveCOverriderOfOverriderCallsSuperclass = false
    }


    //  Hybrid

    func testOverriderOfInheritorSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.overriddenAtLevel2.rawValue

        XCTAssertEqual(SwiftOverriderOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftOverriderOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCOverriderOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCOverriderOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }

    func testOverriderOfInheritorSpyableMethodsCallingSuperclass() {
        SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = true
        ObjectiveCOverriderOfInheritorCallsSuperclass = true
        expectedMethodOutput = WellKnownMethodReturnValues.definedAtRoot.rawValue

        XCTAssertEqual(SwiftOverriderOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftOverriderOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCOverriderOfInheritor.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCOverriderOfInheritor().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = false
        ObjectiveCOverriderOfInheritorCallsSuperclass = false
    }

    func testInheritorOfOverriderSpyableMethods() {
        expectedMethodOutput = WellKnownMethodReturnValues.overriddenAtLevel1.rawValue

        XCTAssertEqual(SwiftInheritorOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(SwiftInheritorOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)

        XCTAssertEqual(ObjectiveCInheritorOfOverrider.sampleClassMethod(""),
                       expectedMethodOutput, defaultMessage)
        XCTAssertEqual(ObjectiveCInheritorOfOverrider().sampleInstanceMethod(""),
                       expectedMethodOutput, defaultMessage)
    }

}
