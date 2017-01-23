//
//  IndirectInvocationInstanceSpyingTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


class IndirectInvocationInstanceSpyingTests: XCTestCase {

    var swiftSpy: SwiftRootSpyable.IndirectInvocationInstanceSpy!
    var swiftSpyable = SwiftOverrider()

    var objectiveCSpy: ObjectiveCRootSpyable.IndirectInvocationInstanceSpy!
    var objectiveCSpyable = ObjectiveCOverrider()

    override func setUp() {
        super.setUp()

        swiftSpy = SwiftRootSpyable.IndirectInvocationInstanceSpy(on: swiftSpyable)
        objectiveCSpy = ObjectiveCRootSpyable.IndirectInvocationInstanceSpy(on: objectiveCSpyable)
    }

    override func tearDown() {
        swiftSpy.endSpying()
        objectiveCSpy.endSpying()

        SwiftRootSpyable.IndirectInvocationInstanceSpy.forwardsMethodCalls = false
        ObjectiveCRootSpyable.IndirectInvocationInstanceSpy.forwardsMethodCalls = false

        super.tearDown()
    }

    
    //  MARK: - Swift spies

    func testForwardingSwiftSpyWithContext() {
        SwiftRootSpyable.IndirectInvocationInstanceSpy.forwardsMethodCalls = true
        swiftSpy.spy {
            XCTAssertEqual(
                swiftSpyable.sampleInstanceMethod("test"),
                FirstOverridingMethodReturnValue,
                "The spy method should be invoked instead of the true method which should be forwarded"
            )
        }
    }

    func testForwardingSwiftSpyWithoutContext() {
        SwiftRootSpyable.IndirectInvocationInstanceSpy.forwardsMethodCalls = true
        swiftSpy.beginSpying()
        XCTAssertEqual(
            swiftSpyable.sampleInstanceMethod("test"),
            FirstOverridingMethodReturnValue,
            "The spy method should be invoked instead of the true method which should be forwarded"
        )
        swiftSpy.endSpying()
    }

    func testNonForwardingSwiftSpyWithContext() {
        swiftSpy.spy {
            XCTAssertEqual(
                swiftSpyable.sampleInstanceMethod("test"),
                DirectInvocationSpyDummyReturnValue,
                "The spy method should be invoked instead of the true method which should not be forwarded"
            )
        }
    }

    func testNonForwardingSwiftSpyWithoutContext() {
        swiftSpy.beginSpying()
        XCTAssertEqual(
            swiftSpyable.sampleInstanceMethod("test"),
            DirectInvocationSpyDummyReturnValue,
            "The spy method should be invoked instead of the true method which should not be forwarded"
        )
        swiftSpy.endSpying()
    }
    

    //  MARK: - Objective-C spies

    func testForwardingObjectiveCSpyWithContext() {
        ObjectiveCRootSpyable.IndirectInvocationInstanceSpy.forwardsMethodCalls = true
        objectiveCSpy.spy {
            XCTAssertEqual(
                objectiveCSpyable.sampleInstanceMethod("test"),
                FirstOverridingMethodReturnValue,
                "The spy method should be invoked instead of the true method which should be forwarded"
            )
        }
    }

    func testForwardingObjectiveCSpyWithoutContext() {
        ObjectiveCRootSpyable.IndirectInvocationInstanceSpy.forwardsMethodCalls = true
        objectiveCSpy.beginSpying()
        XCTAssertEqual(
            objectiveCSpyable.sampleInstanceMethod("test"),
            FirstOverridingMethodReturnValue,
            "The spy method should be invoked instead of the true method which should be forwarded"
        )
        objectiveCSpy.endSpying()
    }

    func testNonForwardingObjectiveCSpyWithContext() {
        objectiveCSpy.spy {
            XCTAssertEqual(
                objectiveCSpyable.sampleInstanceMethod("test"),
                DirectInvocationSpyDummyReturnValue,
                "The spy method should be invoked instead of the true method which should not be forwarded"
            )
        }
    }

    func testNonForwardingObjectiveCSpyWithoutContext() {
        objectiveCSpy.beginSpying()
        XCTAssertEqual(
            objectiveCSpyable.sampleInstanceMethod("test"),
            DirectInvocationSpyDummyReturnValue,
            "The spy method should be invoked instead of the true method which should not be forwarded"
        )
        objectiveCSpy.endSpying()
    }

}
