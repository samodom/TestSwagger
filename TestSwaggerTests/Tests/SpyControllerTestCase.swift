//
//  SpyControllerTestCase.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import FoundationSwagger
import TestSwagger


class SpyControllerTestCase: XCTestCase {

    enum SpyLanguage {
        case swift
        case objectiveC
    }

    var inContext = false
    var language = SpyLanguage.swift

    var vector: SpyVector {
        fatalError("Each spy test case subclass should define its own spy vector")
    }

    var methodType: MethodType {
        fatalError("Each spy test case subclass should define its own method type")
    }

    var rootSpyableClass: AnyClass {
        switch language {
        case .swift:
            return SwiftRootSpyable.self

        case .objectiveC:
            return ObjectiveCRootSpyable.self
        }
    }

    var controller: SpyController.Type {
        switch (language, vector, methodType) {
        case (.swift, .direct, .class):
            return SwiftRootSpyable.DirectClassSpyController.self

        case (.swift, .direct, .instance):
            return SwiftRootSpyable.DirectObjectSpyController.self

        case (.swift, .indirect, .class):
            return SwiftRootSpyable.IndirectClassSpyController.self

        case (.swift, .indirect, .instance):
            return SwiftRootSpyable.IndirectObjectSpyController.self

        case (.objectiveC, .direct, .class):
            return ObjectiveCRootSpyable.DirectClassSpyController.self

        case (.objectiveC, .direct, .instance):
            return ObjectiveCRootSpyable.DirectObjectSpyController.self

        case (.objectiveC, .indirect, .class):
            return ObjectiveCRootSpyable.IndirectClassSpyController.self

        case (.objectiveC, .indirect, .instance):
            return ObjectiveCRootSpyable.IndirectObjectSpyController.self
        }
    }

    var shouldForwardMethodCalls = false
    var spyExpectations: [SpyTestOutputExpectation]!

    override func tearDown() {
        spyExpectations?.forEach { expectation in
            expectation.spy.endSpying()
        }

        setSpyMethodCallForwarding(to: false)
        setSpySuperclassMethodCalling(to: false)

        super.tearDown()
    }

    func setSpyMethodCallForwarding(to shouldForward: Bool) {
        SwiftRootSpyable.setAllSpyMethodForwarding(to: shouldForward)
        ObjectiveCRootSpyable.setAllSpyMethodForwarding(to: shouldForward)
    }

    func setSpySuperclassMethodCalling(to shouldCall: Bool) {
        SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = shouldCall
        SwiftOverrider.swiftOverriderCallsSuperclass = shouldCall
        SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = shouldCall

        ObjectiveCOverriderOfInheritorCallsSuperclass = ObjCBool(shouldCall)
        ObjectiveCOverriderCallsSuperclass = ObjCBool(shouldCall)
        ObjectiveCOverriderOfOverriderCallsSuperclass = ObjCBool(shouldCall)
    }

}


extension SpyControllerTestCase {

    var unforwardedOutputValue: Int? {
        return shouldForwardMethodCalls ? nil : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    func createSpyExpectations() {

        setSpyMethodCallForwarding(to: shouldForwardMethodCalls)

        switch (language, vector, methodType) {
        case (.swift, .direct(_), .`class`):
            spyExpectations = createSwiftDirectInvocationClassSpyExpectations()

        case (.swift, .direct(_), .instance):
            spyExpectations = createSwiftDirectInvocationObjectSpyExpectations()

        case (.swift, .indirect(_), .`class`):
            spyExpectations = createSwiftIndirectInvocationClassSpyExpectations()

        case (.swift, .indirect(_), .instance):
            spyExpectations = createSwiftIndirectInvocationObjectSpyExpectations()

        case (.objectiveC, .direct(_), .`class`):
            spyExpectations = createObjectiveCDirectInvocationClassSpyExpectations()

        case (.objectiveC, .direct(_), .instance):
            spyExpectations = createObjectiveCDirectInvocationObjectSpyExpectations()

        case (.objectiveC, .indirect(_), .`class`):
            spyExpectations = createObjectiveCIndirectInvocationClassSpyExpectations()

        case (.objectiveC, .indirect(_)  , .instance):
            spyExpectations = createObjectiveCIndirectInvocationObjectSpyExpectations()
        }

        assert(!spyExpectations.isEmpty)
    }

    func validateSpyExpectation(
        _ expectation: SpyTestOutputExpectation,
        inFile file: String = #file,
        atLine line: UInt = #line
        ) {

        let output = executeSampleMethod(for: expectation)
        if output != expectation.output {
            recordFailure(
                withDescription: methodSwizzlingErrorMessage(
                    for: expectation,
                    output: output
                ),
                inFile: file,
                atLine: line,
                expected: true
            )
        }

    }

    private func executeSampleMethod(for expectation: SpyTestOutputExpectation) -> Int {
        let spy = expectation.spy

        if inContext {
            var output: Int?
            spy.spy {
                output = expectation.executeSampleMethod()
            }
            return output!
        }
        else {
            spy.beginSpying()
            let output = expectation.executeSampleMethod()
            spy.endSpying()
            return output
        }
    }

    private func methodSwizzlingErrorMessage(for expectation: SpyTestOutputExpectation, output: Int) -> String {
        let spyClassName = rootSpyableClass.debugDescription()
        let methodOrigin = shouldForwardMethodCalls ? "original" : "spy"
        return "The \(methodOrigin) method was not invoked: \(output) != \(expectation.output) for class \(spyClassName)"
    }

}
