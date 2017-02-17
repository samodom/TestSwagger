//
//  SpyCreationTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/22/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes
import TestSwagger


class SpyCreationTests: XCTestCase {

    // MARK: - Swift / direct / class

    func testCannotCreateSwiftDirectClassSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: swiftRootClass.self),
            "Should not be able to create a direct spy with the root Swift class"
        )
    }

    func testCannotCreateSwiftDirectClassSpyWithNSObject() {
        XCTAssertNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: NSObject.self),
            "Should not be able to create a direct spy with NSObject"
        )
    }

    func testCannotCreateSwiftDirectClassSpyWithInvalidSubclass() {
        XCTAssertNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: URLSession.self),
            "Should not be able to create a direct spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateSwiftSpyDirectClassWithRootClass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: SwiftRootSpyable.self),
            "Should be able to create a direct spy with the root spyable class"
        )
    }

    func testCanCreateSwiftSpyDirectClassWithDirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: SwiftInheritor.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateSwiftSpyDirectClassWithIndirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.DirectClassSpyController.createSpy(on: SwiftOverriderOfOverrider.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }


    // MARK: - Objective-C / direct / class

    func testCannotCreateObjectiveCDirectClassSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: swiftRootClass.self),
            "Should not be able to create a direct spy with the root Swift class"
        )
    }

    func testCannotCreateObjectiveCDirectClassSpyWithNSObject() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: NSObject.self),
            "Should not be able to create a direct spy with NSObject"
        )
    }

    func testCannotCreateObjectiveCDirectClassSpyWithInvalidSubclass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: URLSession.self),
            "Should not be able to create a direct spy with a class that does not inherit from the spyable class"
        )
    }

    func testCanCreateObjectiveCDirectClassSpyWithRootClass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: ObjectiveCRootSpyable.self),
            "Should be able to create a direct spy with the root spyable class"
        )
    }

    func testCanCreateObjectiveCDirectClassSpyWithDirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: ObjectiveCInheritor.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateObjectiveCDirectClassSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.DirectClassSpyController.createSpy(on: ObjectiveCOverriderOfOverrider.self),
            "Should be able to create a direct spy with a direct subclass of the root spyable class"
        )
    }


    // MARK: - Swift / indirect / class

    func testCannotCreateSwiftIndirectClassSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            SwiftRootSpyable.IndirectClassSpyController.createSpy(on: swiftRootClass.self),
            "Should not be able to create an indirect spy with the root Swift class"
        )
    }

    func testCannotCreateSwiftIndirectClassSpyWithNSObject() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectClassSpyController.createSpy(on: NSObject.self),
            "Should not be able to create an indirect spy with NSObject"
        )
    }

    func testCannotCreateSwiftIndirectClassSpyWithInvalidSubclass() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectClassSpyController.createSpy(on: URLSession.self),
            "Should not be able to create an indirect spy with a class that does not inherit from the spyable class"
        )
    }

    func testCannotCreateSwiftIndirectClassSpyWithRootClass() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectClassSpyController.createSpy(on: SwiftRootSpyable.self),
            "Should not be able to create an indirect spy with the root spyable class"
        )
    }

    func testCanCreateSwiftIndirectClassSpyWithDirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.IndirectClassSpyController.createSpy(on: SwiftInheritor.self),
            "Should be able to create an indirect spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateSwiftIndirectClassSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.IndirectClassSpyController.createSpy(on: SwiftOverriderOfOverrider.self),
            "Should be able to create an indirect spy with a direct subclass of the root spyable class"
        )
    }


    // MARK: - Objective-C / indirect / class

    func testCannotCreateObjectiveCIndirectClassSpyWithRootSwiftClass() {
        let swiftRootClass: AnyClass = objc_getClass("SwiftObject") as! AnyClass
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectClassSpyController.createSpy(on: swiftRootClass.self),
            "Should not be able to create an indirect spy with the root Swift class"
        )
    }

    func testCannotCreateObjectiveCIndirectClassSpyWithNSObject() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectClassSpyController.createSpy(on: NSObject.self),
            "Should not be able to create an indirect spy with NSObject"
        )
    }

    func testCannotCreateObjectiveCIndirectClassSpyWithInvalidSubclass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectClassSpyController.createSpy(on: URLSession.self),
            "Should not be able to create an indirect spy with a class that does not inherit from the spyable class"
        )
    }

    func testCannotCreateObjectiveCIndirectClassSpyWithRootClass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectClassSpyController.createSpy(on: ObjectiveCRootSpyable.self),
            "Should not be be able to create an indirect spy with the root spyable class"
        )
    }

    func testCanCreateObjectiveCIndirectClassSpyWithDirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.IndirectClassSpyController.createSpy(on: ObjectiveCInheritor.self),
            "Should be able to create an indirect spy with a direct subclass of the root spyable class"
        )
    }

    func testCanCreateObjectiveCIndirectClassSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.IndirectClassSpyController.createSpy(on: ObjectiveCOverriderOfOverrider.self),
            "Should be able to create an indirect spy with a direct subclass of the root spyable class"
        )
    }


    // MARK: - Swift / indirect / object

    func testCannotCreateSwiftIndirectObjectSpyWithRootClass() {
        XCTAssertNil(
            SwiftRootSpyable.IndirectObjectSpyController.createSpy(on: SwiftRootSpyable()),
            "Should not be able to create an indirect spy with an instance of the root spyable class"
        )
    }

    func testCanCreateSwiftIndirectObjectSpyWithDirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.IndirectObjectSpyController.createSpy(on: SwiftInheritor()),
            "Should be able to create an indirect spy with an instance of a direct subclass of the root spyable class"
        )
    }

    func testCanCreateSwiftIndirectObjectSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            SwiftRootSpyable.IndirectObjectSpyController.createSpy(on: SwiftOverriderOfOverrider()),
            "Should be able to create an indirect spy with an instance of a direct subclass of the root spyable class"
        )
    }


    // MARK: - Objective-C / indirect / object

    func testCannotCreateObjectiveCIndirectObjectSpyWithRootClass() {
        XCTAssertNil(
            ObjectiveCRootSpyable.IndirectObjectSpyController.createSpy(on: ObjectiveCRootSpyable()),
            "Should not be able to create an indirect spy with an instance of the root spyable class"
        )
    }

    func testCanCreateObjectiveCIndirectObjectSpyWithDirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.IndirectObjectSpyController.createSpy(on: ObjectiveCInheritor()),
            "Should be able to create an indirect spy with an instance of a direct subclass of the root spyable class"
        )
    }

    func testCanCreateObjectiveCIndirectObjectSpyWithIndirectSubclass() {
        XCTAssertNotNil(
            ObjectiveCRootSpyable.IndirectObjectSpyController.createSpy(on: ObjectiveCOverriderOfOverrider()),
            "Should be able to create an indirect spy with an instance of a direct subclass of the root spyable class"
        )
    }

}
