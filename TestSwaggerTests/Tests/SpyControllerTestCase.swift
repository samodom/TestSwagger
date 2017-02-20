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
@testable import TestSwagger


private let dummyKeyString = UUIDKeyString()
let dummyKey = ObjectAssociationKey(dummyKeyString)
let dummyPath = TemporaryDirectoryUrl.appendingPathComponent("decoyFile").path


class SpyControllerTestCase: XCTestCase {

    var currentVariant: SpyTestVariant!
    var currentCodeSource: CodeSource!
    var currentExpectation: SpyTestOutputExpectation!
    var spyExpectations: [SpyTestOutputExpectation]!

    let decoyEvidence: Set = [
        SpyEvidenceReference(key: dummyKey),
        SpyEvidenceReference(path: dummyPath)
    ]

    var subject: Any {
        return currentExpectation.subject
    }

    var subjectAsObjectSpyable: SampleObjectSpyable? {
        return subject as? SampleObjectSpyable
    }

    var subjectAsClassSpyable: SampleClassSpyable.Type? {
        return subject as? SampleClassSpyable.Type
    }

    var spy: Spy {
        return currentExpectation.spy
    }

    var evidence: Set<SpyEvidenceReference> {
        return spy.evidence
    }

    var controller: SpyController.Type {
        return currentVariant.controller
    }

    var unforwardedOutput: Int? {
        return currentVariant.unforwardedOutputValue
    }

    override func tearDown() {
        setSpyMethodCallForwarding(to: false)
        setSpySuperclassMethodCalling(to: false)

        super.tearDown()
    }


    func runSpyControllerTests(
        for variant: SpyTestVariant,
        inFile file: String = #file,
        atLine line: UInt = #line
        ) {

        currentVariant = variant
        currentCodeSource = CodeSource(file: file, line: line)
        createSpyExpectations()

        spyExpectations.forEach { expectation in
            currentExpectation = expectation

            createDecoyEvidence()

            validateExpectation()
            verifyEvidenceCleanup()

            deleteAllEvidence()
        }
    }

}


fileprivate extension SpyControllerTestCase {

    func setSpyMethodCallForwarding(to shouldForward: Bool) {
        SwiftRootSpyable.DirectClassSpyController.forwardingBehavior = .custom(shouldForward)
        SwiftRootSpyable.DirectObjectSpyController.forwardingBehavior = .custom(shouldForward)
        SwiftRootSpyable.IndirectClassSpyController.forwardingBehavior = .custom(shouldForward)
        SwiftRootSpyable.IndirectObjectSpyController.forwardingBehavior = .custom(shouldForward)

        ObjectiveCRootSpyable.DirectClassSpyController.forwardingBehavior = .custom(shouldForward)
        ObjectiveCRootSpyable.DirectObjectSpyController.forwardingBehavior = .custom(shouldForward)
        ObjectiveCRootSpyable.IndirectClassSpyController.forwardingBehavior = .custom(shouldForward)
        ObjectiveCRootSpyable.IndirectObjectSpyController.forwardingBehavior = .custom(shouldForward)
    }

    func setSpySuperclassMethodCalling(to shouldCall: Bool) {
        SwiftOverrider.swiftOverriderCallsSuperclass = shouldCall
        SwiftOverriderOfInheritor.swiftOverriderOfInheritorCallsSuperclass = shouldCall
        SwiftOverriderOfOverrider.swiftOverriderOfOverriderCallsSuperclass = shouldCall

        ObjectiveCOverriderCallsSuperclass = ObjCBool(shouldCall)
        ObjectiveCOverriderOfInheritorCallsSuperclass = ObjCBool(shouldCall)
        ObjectiveCOverriderOfOverriderCallsSuperclass = ObjCBool(shouldCall)
    }

    func createSpyExpectations() {
        setSpyMethodCallForwarding(to: currentVariant.forwardsCalls)

        switch (currentVariant.language, currentVariant.vector, currentVariant.methodType) {
        case (.swift, .direct, .`class`):
            spyExpectations = createSwiftDirectInvocationClassSpyExpectations()

        case (.swift, .direct, .instance):
            spyExpectations = createSwiftDirectInvocationObjectSpyExpectations()

        case (.swift, .indirect, .`class`):
            spyExpectations = createSwiftIndirectInvocationClassSpyExpectations()

        case (.swift, .indirect, .instance):
            spyExpectations = createSwiftIndirectInvocationObjectSpyExpectations()

        case (.objectiveC, .direct, .`class`):
            spyExpectations = createObjectiveCDirectInvocationClassSpyExpectations()

        case (.objectiveC, .direct, .instance):
            spyExpectations = createObjectiveCDirectInvocationObjectSpyExpectations()

        case (.objectiveC, .indirect, .`class`):
            spyExpectations = createObjectiveCIndirectInvocationClassSpyExpectations()

        case (.objectiveC, .indirect, .instance):
            spyExpectations = createObjectiveCIndirectInvocationObjectSpyExpectations()
        }

        assert(!spyExpectations.isEmpty)
    }

    func createDecoyEvidence() {
        decoyEvidence.forEach { reference in
            subjectAsObjectSpyable?.saveEvidence(true, with: reference)
            subjectAsClassSpyable?.saveEvidence(true, with: reference)
        }
    }

    func deleteAllEvidence() {
        decoyEvidence.union(evidence).forEach { reference in
            subjectAsObjectSpyable?.removeEvidence(with: reference)
            subjectAsClassSpyable?.removeEvidence(with: reference)
        }
    }

    func validateExpectation() {
        let realOutput = executeSampleMethod()

        if realOutput != currentExpectation.output {
            recordFailure(
                withDescription: methodSwizzlingErrorMessage(realOutput: realOutput),
                at: currentCodeSource
            )
        }
    }

    private func executeSampleMethod() -> Int {
        verifyEvidenceFlagsSet(to: false)

        var output: Int!
        if currentVariant.inContext {
            spy.spy {
                output = currentExpectation.executeSampleMethod()
                verifyEvidenceFlagsSet(to: true)
            }
        }
        else {
            spy.beginSpying()
            output = currentExpectation.executeSampleMethod()
            verifyEvidenceFlagsSet(to: true)
            spy.endSpying()
        }

        return output
    }

    private func methodSwizzlingErrorMessage(realOutput: Int) -> String {
        let spyClassName = currentVariant.controller.rootSpyableClass.debugDescription()
        let methodOrigin = currentVariant.forwardsCalls ? "original" : "spy"

        return "The \(methodOrigin) method was not invoked: \(realOutput) != \(currentExpectation.output) for class \(spyClassName)"
    }

    func verifyEvidenceCleanup() {
        evidence.forEach { reference in
            if !evidenceWasRemoved(with: reference) {
                let message = "Evidence should automatically be removed after spying is complete:\n"
                    .appending(currentVariant.description)
                recordFailure(withDescription: message, at: currentCodeSource)
            }
        }

        decoyEvidence.forEach { reference in
            if evidenceWasRemoved(with: reference) {
                let message = "Evidence outside the scope of the spy controller should not be removed\n"
                    .appending(currentVariant.description)
                recordFailure(withDescription: message, at: currentCodeSource)
            }
        }
    }


    private static let flagNotCapturedErrorMessage = "The evidence was not captured\n"
    private static let flagNotClearedErrorMessage = "The evidence is not clear\n"
    private static let nonSpyableSubjectErrorMessage = "Testing a non-spyable subject\n"

    private func verifyEvidenceFlagsSet(to expectedFlag: Bool) {
        let errorMessageHeader = expectedFlag ?
            SpyControllerTests.flagNotCapturedErrorMessage :
            SpyControllerTests.flagNotClearedErrorMessage
        let errorMessage = errorMessageHeader.appending(currentVariant.description)

        if let spyableObject = subjectAsObjectSpyable {
            if spyableObject.sampleInstanceMethodCalledAssociated != expectedFlag ||
                spyableObject.sampleInstanceMethodCalledSerialized != expectedFlag {
                recordFailure(withDescription: errorMessage, at: currentCodeSource)
            }
        }
        else if let spyableClass = subjectAsClassSpyable {
            if spyableClass.sampleClassMethodCalledAssociated != expectedFlag ||
                spyableClass.sampleClassMethodCalledSerialized != expectedFlag {

                recordFailure(withDescription: errorMessage, at: currentCodeSource)
            }
        }
        else {
            fatalError(SpyControllerTests.nonSpyableSubjectErrorMessage)
        }
    }

    private func evidenceWasRemoved(with reference: SpyEvidenceReference) -> Bool {
        if let spyableObject = subjectAsObjectSpyable {
            return spyableObject.loadEvidence(with: reference) == nil
        }
        else if let spyableClass = subjectAsClassSpyable {
            return spyableClass.loadEvidence(with: reference) == nil
        }
        else {
            fatalError(SpyControllerTests.nonSpyableSubjectErrorMessage)
        }
    }

}
