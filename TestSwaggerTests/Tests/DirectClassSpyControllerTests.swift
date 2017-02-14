//
//  DirectClassSpyControllerTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes
import TestSwagger


class DirectClassSpyControllerTests: SpyControllerTestCase {

    override var vector: SpyVector {
        return .direct
    }

    override var methodType: MethodType {
        return .`class`
    }

    // MARK: - Swift spies

    func testCannotCreateSwiftSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: swiftRootClass.self),
            "Should not be able to create a direct spy with the root Swift class"
        )
    }

    func testCannotCreateSwiftSpyWithNSObject() {
        XCTAssertNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: NSObject.self),
            "Should not be able to create a direct spy with NSObject"
        )
    }

    func testCannotCreateSwiftSpyWithInvalidSubclass() {
        XCTAssertNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: URLSession.self),
            "Should not be able to create a direct spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateSwiftSpyWithRootClass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: SwiftRootSpyable.self),
            "Should be able to create a direct spy with the root spyable class"
        )
    }

    func testCanCreateSwiftSpyWithDirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: SwiftInheritor.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateSwiftSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: SwiftOverriderOfOverrider.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testForwardingSwiftSpyWithContext() {
        inContext = true
        shouldForwardMethodCalls = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testForwardingSwiftSpyWithoutContext() {
        shouldForwardMethodCalls = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testNonForwardingSwiftSpyWithContext() {
        inContext = true
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }

    func testNonForwardingSwiftSpyWithoutContext() {
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            validateSpyExpectation(expectation)
        }
    }


    // MARK: - Objective-C spies

    func testCannotCreateObjectiveCSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: swiftRootClass.self),
            "Should not be able to create a direct spy with the root Swift class"
        )
    }

    func testCannotCreateObjectiveCSpyWithNSObject() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: NSObject.self),
            "Should not be able to create a direct spy with NSObject"
        )
    }

    func testCannotCreateObjectiveCSpyWithInvalidSubclass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: URLSession.self),
            "Should not be able to create a direct spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithRootClass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: ObjectiveCRootSpyable.self),
            "Should be able to create a direct spy with the root spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithDirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: ObjectiveCInheritor.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: ObjectiveCOverriderOfOverrider.self),
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
