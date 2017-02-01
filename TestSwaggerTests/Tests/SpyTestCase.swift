//
//  SpyTestCase.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import FoundationSwagger
import TestSwagger


class SpyTestCase: XCTestCase {

    enum SpyLanguage {
        case swift
        case objectiveC
    }

    enum SpyVector {
        case direct
        case indirect
    }

    var inContext = false
    var language = SpyLanguage.swift

    var vector: SpyVector {
        return .direct
    }

    var methodType: MethodType {
        return .class
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


extension SpyTestCase {

    var unforwardedOutputValue: Int? {
        return shouldForwardMethodCalls ? nil : WellKnownMethodReturnValues.commonSpyValue.rawValue
    }

    func createSpyExpectations() {

        setSpyMethodCallForwarding(to: shouldForwardMethodCalls)

        switch (language, vector, methodType) {
        case (.swift, .direct, .`class`):
            spyExpectations = createSwiftDirectInvocationClassSpyExpectations()

        case (.swift, .direct, .instance):
            spyExpectations = createSwiftDirectInvocationInstanceSpyExpectations()

        case (.swift, .indirect, .`class`):
            spyExpectations = createSwiftIndirectInvocationClassSpyExpectations()

        case (.swift, .indirect, .instance):
            spyExpectations = createSwiftIndirectInvocationInstanceSpyExpectations()

        case (.objectiveC, .direct, .`class`):
            spyExpectations = createObjectiveCDirectInvocationClassSpyExpectations()

        case (.objectiveC, .direct, .instance):
            spyExpectations = createObjectiveCDirectInvocationInstanceSpyExpectations()

        case (.objectiveC, .indirect, .`class`):
            spyExpectations = createObjectiveCIndirectInvocationClassSpyExpectations()

        case (.objectiveC, .indirect, .instance):
            spyExpectations = createObjectiveCIndirectInvocationInstanceSpyExpectations()
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
        let spyClassName = expectation.spy.surrogate.owningClass.debugDescription()
        let methodOrigin = shouldForwardMethodCalls ? "original" : "spy"
        return "The \(methodOrigin) method was not invoked: \(output) != \(expectation.output) for class \(spyClassName)"
    }

}
