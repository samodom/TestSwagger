//
//  SpyControllerTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import SampleTypes
import TestSwagger


class SpyControllerTests: SpyControllerTestCase {

    // MARK: - THIS IS THE BIG TEST!!!
    func testAllSpyVariants() {
        SpyTestVariant.allVariants.forEach {
            runSpyControllerTests(for: $0)
        }
    }

}


extension SpyControllerTests {

    func testMultipleSpyMethodsPerSpyWithContext() {
        let object = SwiftRootSpyable()
        let spy = SwiftRootSpyable.MultipleMethodSpyController.createSpy(on: object)!
        var contextExecutionCount = 0

        spy.spy {
            contextExecutionCount += 1

            object.additionalInstanceMethod()
            XCTAssertTrue(object.additionalInstanceMethodSpyCalled,
                          "The additional spy method should have been invoked")

            _ = object.sampleInstanceMethod("")
            XCTAssertTrue(object.sampleInstanceMethodCalledAssociated,
                          "The sample spy method should have been called")
            XCTAssertTrue(object.sampleInstanceMethodCalledSerialized,
                          "The sample spy method should have been called")
        }

        XCTAssertEqual(contextExecutionCount, 1,
                       "The context should only be executed once despite have two method surrogates")

        var message = "All spy evidence should be cleared"
        XCTAssertFalse(object.additionalInstanceMethodSpyCalled, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledAssociated, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledSerialized, message)

        object.additionalInstanceMethod()
        _ = object.sampleInstanceMethod("")

        message = "The methods should no longer be swizzled"
        XCTAssertFalse(object.additionalInstanceMethodSpyCalled, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledAssociated, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledSerialized, message)
    }

    func testMultipleSpyMethodsPerSpyWithoutContext() {
        let object = SwiftRootSpyable()
        let spy = SwiftRootSpyable.MultipleMethodSpyController.createSpy(on: object)!

        spy.beginSpying()

        object.additionalInstanceMethod()
        XCTAssertTrue(object.additionalInstanceMethodSpyCalled,
                      "The additional spy method should have been invoked")

        _ = object.sampleInstanceMethod("")
        XCTAssertTrue(object.sampleInstanceMethodCalledAssociated,
                      "The sample spy method should have been called")
        XCTAssertTrue(object.sampleInstanceMethodCalledSerialized,
                      "The sample spy method should have been called")

        spy.endSpying()

        var message = "All spy evidence should be cleared"
        XCTAssertFalse(object.additionalInstanceMethodSpyCalled, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledAssociated, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledSerialized, message)

        object.additionalInstanceMethod()
        _ = object.sampleInstanceMethod("")

        message = "The methods should no longer be swizzled"
        XCTAssertFalse(object.additionalInstanceMethodSpyCalled, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledAssociated, message)
        XCTAssertFalse(object.sampleInstanceMethodCalledSerialized, message)
    }

}


extension SwiftRootSpyable {

    private static let additionalSpyMethodKeyString = UUIDKeyString()
    private static let additionalSpyMethodKey = ObjectAssociationKey(additionalSpyMethodKeyString)
    private static let additionalSpyMethodReference = SpyEvidenceReference(key: additionalSpyMethodKey)

    private static let additionalSpyMethodCoselectors = SpyCoselectors(
        methodType: .instance,
        original: #selector(SwiftRootSpyable.additionalInstanceMethod),
        spy: #selector(SwiftRootSpyable.spy_additionalInstanceMethod)
    )

    enum MultipleMethodSpyController: SpyController {
        static let rootSpyableClass: AnyClass = SwiftRootSpyable.self
        static let vector = SpyVector.direct
        static let coselectors = SwiftRootSpyable.DirectObjectSpyController.coselectors
            .union([additionalSpyMethodCoselectors])
        static let evidence = SwiftRootSpyable.DirectObjectSpyController.evidence.union([additionalSpyMethodReference])
        static let forwardsInvocations = false
    }

    var additionalInstanceMethodSpyCalled: Bool {
        get {
            return loadEvidence(with: SwiftRootSpyable.additionalSpyMethodReference) as? Bool ?? false
        }
        set {
            let reference = SwiftRootSpyable.additionalSpyMethodReference
            guard newValue else {
                return removeEvidence(with: reference)
            }

            saveEvidence(true, with: reference)
        }
    }

    dynamic func additionalInstanceMethod() -> Void {}

    dynamic func spy_additionalInstanceMethod() -> Void {
        additionalInstanceMethodSpyCalled = true
    }

}
