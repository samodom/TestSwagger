//
//  DirectInvocationClassSpyingTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


class DirectInvocationClassSpyingTests: DirectInvocationSpyingTestCase {

    //  MARK: - Swift spies

    func testCannotCreateSwiftSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            SwiftRootSpyable.DirectInvocationClassSpy(on: swiftRootClass.self),
            "Should not be able to create a direct spy with the root Swift class"
        )
    }

    func testCannotCreateSwiftSpyWithNSObject() {
        XCTAssertNil(
            SwiftRootSpyable.DirectInvocationClassSpy(on: NSObject.self),
            "Should not be able to create a direct spy with NSObject"
        )
    }

    func testCannotCreateSwiftSpyWithRootClass() {
        XCTAssertNil(
            SwiftRootSpyable.DirectInvocationClassSpy(on: SwiftRootSpyable.self),
            "Should not be able to create a direct spy with the root spyable class"
        )
    }

    func testCannotCreateSwiftSpyWithInvalidSubclass() {
        XCTAssertNil(
            SwiftRootSpyable.DirectInvocationClassSpy(on: URLSession.self),
            "Should not be able to create a direct spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateSwiftSpyWithDirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectInvocationClassSpy(on: SwiftInheritor.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateSwiftSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectInvocationClassSpy(on: SwiftOverriderOfOverrider.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testForwardingSwiftSpyWithContext() {
        language = .swift
        inContext = true
        shouldForwardMethodCalls = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testForwardingSwiftSpyWithoutContext() {
        language = .swift
        shouldForwardMethodCalls = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testNonForwardingSwiftSpyWithContext() {
        language = .swift
        inContext = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testNonForwardingSwiftSpyWithoutContext() {
        language = .swift
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }


    //  MARK: - Objective-C spies

    func testCannotCreateObjectiveCSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectInvocationClassSpy(on: swiftRootClass.self),
            "Should not be able to create a direct spy with the root Swift class"
        )
    }

    func testCannotCreateObjectiveCSpyWithNSObject() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectInvocationClassSpy(on: NSObject.self),
            "Should not be able to create a direct spy with NSObject"
        )
    }

    func testCannotCreateObjectiveCSpyWithRootClass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectInvocationClassSpy(on: ObjectiveCRootSpyable.self),
            "Should not be able to create a direct spy with the root spyable class"
        )
    }

    func testCannotCreateObjectiveCSpyWithInvalidSubclass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectInvocationClassSpy(on: URLSession.self),
            "Should not be able to create a direct spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithDirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectInvocationClassSpy(on: ObjectiveCInheritor.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectInvocationClassSpy(on: ObjectiveCOverriderOfOverrider.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testForwardingObjectiveCSpyWithContext() {
        language = .objectiveC
        inContext = true
        shouldForwardMethodCalls = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testForwardingObjectiveCSpyWithoutContext() {
        language = .objectiveC
        shouldForwardMethodCalls = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testNonForwardingObjectiveCSpyWithContext() {
        language = .objectiveC
        inContext = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testNonForwardingObjectiveCSpyWithoutContext() {
        language = .objectiveC
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

}
