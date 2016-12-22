//
//  SampleSpyableTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest

class SampleSpyableTests: XCTestCase {

    var spyableClasses: [AnyClass]!

    func testRootSpyableMethods() {
        XCTAssertEqual(RootSwiftSpyable.sampleMethod(""),
                       RootMethodReturnValue)
        XCTAssertEqual(RootSwiftSpyable().sampleMethod(""),
                       RootMethodReturnValue)

        XCTAssertEqual(RootObjectiveCSpyable.sampleMethod(""),
                       RootMethodReturnValue)
        XCTAssertEqual(RootObjectiveCSpyable().sampleMethod(""),
                       RootMethodReturnValue)
    }


    //  Inheriting

    func testFirstInheritingSpyableMethods() {
        XCTAssertEqual(FirstInheritingSwiftSpyable.sampleMethod(""),
                       RootMethodReturnValue)
        XCTAssertEqual(FirstInheritingSwiftSpyable().sampleMethod(""),
                       RootMethodReturnValue)

        XCTAssertEqual(FirstInheritingObjectiveCSpyable.sampleMethod(""),
                       RootMethodReturnValue)
        XCTAssertEqual(FirstInheritingObjectiveCSpyable().sampleMethod(""),
                       RootMethodReturnValue)
    }

    func testSecondInheritingSpyableMethods() {
        XCTAssertEqual(SecondInheritingSwiftSpyable.sampleMethod(""),
                       RootMethodReturnValue)
        XCTAssertEqual(SecondInheritingSwiftSpyable().sampleMethod(""),
                       RootMethodReturnValue)

        XCTAssertEqual(SecondInheritingObjectiveCSpyable.sampleMethod(""),
                       RootMethodReturnValue)
        XCTAssertEqual(SecondInheritingObjectiveCSpyable().sampleMethod(""),
                       RootMethodReturnValue)
    }


    //  Overriding

    func testFirstOverridingSpyableMethods() {
        XCTAssertEqual(FirstOverridingSwiftSpyable.sampleMethod(""),
                       FirstOverridingMethodReturnValue)
        XCTAssertEqual(FirstOverridingSwiftSpyable().sampleMethod(""),
                       FirstOverridingMethodReturnValue)

        XCTAssertEqual(FirstOverridingObjectiveCSpyable.sampleMethod(""),
                       FirstOverridingMethodReturnValue)
        XCTAssertEqual(FirstOverridingObjectiveCSpyable().sampleMethod(""),
                       FirstOverridingMethodReturnValue)
    }

    func testSecondOverridingSpyableMethods() {
        XCTAssertEqual(SecondOverridingSwiftSpyable.sampleMethod(""),
                       SecondOverridingMethodReturnValue)
        XCTAssertEqual(SecondOverridingSwiftSpyable().sampleMethod(""),
                       SecondOverridingMethodReturnValue)

        XCTAssertEqual(SecondOverridingObjectiveCSpyable.sampleMethod(""),
                       SecondOverridingMethodReturnValue)
        XCTAssertEqual(SecondOverridingObjectiveCSpyable().sampleMethod(""),
                       SecondOverridingMethodReturnValue)
    }


    //  Hybrid

    func testInheritingOverriderSpyableMethods() {
        XCTAssertEqual(InheritingSwiftSpyableOverrider.sampleMethod(""),
                       SecondOverridingMethodReturnValue)
        XCTAssertEqual(InheritingSwiftSpyableOverrider().sampleMethod(""),
                       SecondOverridingMethodReturnValue)

        XCTAssertEqual(InheritingObjectiveCSpyableOverrider.sampleMethod(""),
                       SecondOverridingMethodReturnValue)
        XCTAssertEqual(InheritingObjectiveCSpyableOverrider().sampleMethod(""),
                       SecondOverridingMethodReturnValue)
    }

    func testOverridingInheritorSpyableMethods() {
        XCTAssertEqual(OverridingSwiftSpyableInheritor.sampleMethod(""),
                       FirstOverridingMethodReturnValue)
        XCTAssertEqual(OverridingSwiftSpyableInheritor().sampleMethod(""),
                       FirstOverridingMethodReturnValue)

        XCTAssertEqual(OverridingObjectiveCSpyableInheritor.sampleMethod(""),
                       FirstOverridingMethodReturnValue)
        XCTAssertEqual(OverridingObjectiveCSpyableInheritor().sampleMethod(""),
                       FirstOverridingMethodReturnValue)
    }

}
