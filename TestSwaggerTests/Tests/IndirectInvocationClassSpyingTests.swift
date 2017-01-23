//
//  IndirectInvocationClassSpyingTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


class IndirectInvocationClassSpyingTests: XCTestCase {

    let swiftSpy = SwiftRootSpyable.IndirectInvocationClassSpy(on: SwiftOverrider.self)
    let objectiveCSpy = ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: ObjectiveCOverrider.self)

    override func tearDown() {
        swiftSpy.endSpying()
        objectiveCSpy.endSpying()

        SwiftRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = false
        ObjectiveCRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = false

        super.tearDown()
    }

    
    //  MARK: - Swift spies

    func testForwardingSwiftSpyWithContext() {
        SwiftRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = true
        swiftSpy.spy {
            XCTAssertEqual(
                SwiftOverrider.sampleClassMethod("test"),
                FirstOverridingMethodReturnValue,
                "The spy method should be invoked instead of the true method which should be forwarded"
            )
        }
    }

    func testForwardingSwiftSpyWithoutContext() {
        SwiftRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = true
        swiftSpy.beginSpying()
        XCTAssertEqual(
            SwiftOverrider.sampleClassMethod("test"),
            FirstOverridingMethodReturnValue,
            "The spy method should be invoked instead of the true method which should be forwarded"
        )
        swiftSpy.endSpying()
    }

    func testNonForwardingSwiftSpyWithContext() {
        swiftSpy.spy {
            XCTAssertEqual(
                SwiftOverrider.sampleClassMethod("test"),
                DirectInvocationSpyDummyReturnValue,
                "The spy method should be invoked instead of the true method which should not be forwarded"
            )
        }
    }

    func testNonForwardingSwiftSpyWithoutContext() {
        swiftSpy.beginSpying()
        XCTAssertEqual(
            SwiftOverrider.sampleClassMethod("test"),
            DirectInvocationSpyDummyReturnValue,
            "The spy method should be invoked instead of the true method which should not be forwarded"
        )
        swiftSpy.endSpying()
    }
    

    //  MARK: - Objective-C spies

    func testForwardingObjectiveCSpyWithContext() {
        ObjectiveCRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = true
        objectiveCSpy.spy {
            XCTAssertEqual(
                ObjectiveCOverrider.sampleClassMethod("test"),
                FirstOverridingMethodReturnValue,
                "The spy method should be invoked instead of the true method which should be forwarded"
            )
        }
    }

    func testForwardingObjectiveCSpyWithoutContext() {
        ObjectiveCRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = true
        objectiveCSpy.beginSpying()
        XCTAssertEqual(
            ObjectiveCOverrider.sampleClassMethod("test"),
            FirstOverridingMethodReturnValue,
            "The spy method should be invoked instead of the true method which should be forwarded"
        )
        objectiveCSpy.endSpying()
    }

    func testNonForwardingObjectiveCSpyWithContext() {
        objectiveCSpy.spy {
            XCTAssertEqual(
                ObjectiveCOverrider.sampleClassMethod("test"),
                DirectInvocationSpyDummyReturnValue,
                "The spy method should be invoked instead of the true method which should not be forwarded"
            )
        }
    }

    func testNonForwardingObjectiveCSpyWithoutContext() {
        objectiveCSpy.beginSpying()
        XCTAssertEqual(
            ObjectiveCOverrider.sampleClassMethod("test"),
            DirectInvocationSpyDummyReturnValue,
            "The spy method should be invoked instead of the true method which should not be forwarded"
        )
        objectiveCSpy.endSpying()
    }

}
