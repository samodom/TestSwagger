//
//  IndirectInvocationClassSpyingTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


class IndirectInvocationClassSpyingTests: IndirectInvocationSpyingTestCase {

    //  MARK: - Swift spies
    func testCannotCreateSwiftSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            SwiftRootSpyable.IndirectInvocationClassSpy(on: swiftRootClass.self),
            "Should not be able to create an indirect spy with the root Swift class"
        )
    }

    func testCannotCreateSwiftSpyWithNSObject() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectInvocationClassSpy(on: NSObject.self),
            "Should not be able to create an indirect spy with NSObject"
        )
    }

    func testCannotCreateSwiftSpyWithRootClass() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectInvocationClassSpy(on: SwiftRootSpyable.self),
            "Should not be able to create an indirect spy with the root spyable class"
        )
    }

    func testCannotCreateSwiftSpyWithInvalidSubclass() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectInvocationClassSpy(on: URLSession.self),
            "Should not be able to create an indirect spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateSwiftSpyWithDirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.IndirectInvocationClassSpy(on: SwiftInheritor.self),
            "Should be able to create an indirect spy with an indirect subclass of the root spyable class"
        )
    }

    func testCanCreateSwiftSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.IndirectInvocationClassSpy(on: SwiftOverriderOfOverrider.self),
            "Should be able to create an indirect spy with an indirect subclass of the root spyable class"
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
            ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: swiftRootClass.self),
            "Should not be able to create an indirect spy with the root Swift class"
        )
    }

    func testCannotCreateObjectiveCSpyWithNSObject() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: NSObject.self),
            "Should not be able to create an indirect spy with NSObject"
        )
    }

    func testCannotCreateObjectiveCSpyWithRootClass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: ObjectiveCRootSpyable.self),
            "Should not be able to create an indirect spy with the root spyable class"
        )
    }

    func testCannotCreateObjectiveCSpyWithInvalidSubclass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: URLSession.self),
            "Should not be able to create an indirect spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithDirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: ObjectiveCInheritor.self),
            "Should be able to create an indirect spy with an indirect subclass of the root spyable class"
        )
    }

    func testCanCreateObjectiveCSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.IndirectInvocationClassSpy(on: ObjectiveCOverriderOfOverrider.self),
            "Should be able to create an indirect spy with an indirect subclass of the root spyable class"
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
