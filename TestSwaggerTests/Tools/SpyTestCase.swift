//
//  SpyTestCase.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
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

    var language = SpyLanguage.swift
    var vector: SpyVector { return .direct }
    var inContext = false
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
        SwiftRootSpyable.DirectInvocationClassSpy.forwardsMethodCalls = shouldForward
        SwiftRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = shouldForward
        ObjectiveCRootSpyable.DirectInvocationClassSpy.forwardsMethodCalls = shouldForward
        ObjectiveCRootSpyable.IndirectInvocationClassSpy.forwardsMethodCalls = shouldForward
    }

    func setSpySuperclassMethodCalling(to shouldCall: Bool) {
        SwiftRootSpyable.callsSuperclass = shouldCall
        SwiftInheritor.callsSuperclass = shouldCall
        SwiftInheritorOfInheritor.callsSuperclass = shouldCall
        SwiftOverriderOfInheritor.callsSuperclass = shouldCall
        SwiftOverrider.callsSuperclass = shouldCall
        SwiftInheritorOfOverrider.callsSuperclass = shouldCall
        SwiftOverriderOfOverrider.callsSuperclass = shouldCall

        ObjectiveCRootSpyable.setCallsSuperclass(shouldCall)
        ObjectiveCInheritor.setCallsSuperclass(shouldCall)
        ObjectiveCInheritorOfInheritor.setCallsSuperclass(shouldCall)
        ObjectiveCOverriderOfInheritor.setCallsSuperclass(shouldCall)
        ObjectiveCOverrider.setCallsSuperclass(shouldCall)
        ObjectiveCInheritorOfOverrider.setCallsSuperclass(shouldCall)
        ObjectiveCOverriderOfOverrider.setCallsSuperclass(shouldCall)
    }

}


extension SpyTestCase {

    var unforwardedOutputValue: Int? {
        return shouldForwardMethodCalls ? nil : SpyMethodReturnValue
    }

    func createSpyExpectations() {

        setSpyMethodCallForwarding(to: shouldForwardMethodCalls)
        setSpySuperclassMethodCalling(to: vector == .indirect)

        switch (language, vector) {
        case (.swift, .direct):
            spyExpectations = createSwiftDirectInvocationSpyExpectations()

        case (.swift, .indirect):
            spyExpectations = createSwiftIndirectInvocationSpyExpectations()

        case (.objectiveC, .direct):
            spyExpectations = createObjectiveCDirectInvocationSpyExpectations()

        case (.objectiveC, .indirect):
            spyExpectations = createObjectiveCIndirectInvocationSpyExpectations()
        }
        
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
        if inContext {
            var output = 0
            expectation.spy.spy {
                output = expectation.executeSampleMethod()
            }
            assert(output != 0)
            return output
        }
        else {
            expectation.spy.beginSpying()
            let output = expectation.executeSampleMethod()
            expectation.spy.endSpying()
            return output
        }
    }

    private func methodSwizzlingErrorMessage(for expectation: SpyTestOutputExpectation, output: Int) -> String {
        let spyClassName = expectation.spy.association.owningClass.debugDescription()
        let methodOrigin = shouldForwardMethodCalls ? "original" : "spy"
        return "The \(methodOrigin) method was not invoked: \(output) != \(expectation.output) for class \(spyClassName)"
    }

}

class DirectInvocationSpyingTestCase: SpyTestCase {}

class IndirectInvocationSpyingTestCase: SpyTestCase {
    override var vector: SpyVector { return .indirect }
}
