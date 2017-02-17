//
//  XCTestCaseSpies.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/15/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import TestSwagger


/// Controller

extension XCTestCase: SpyableObject {

    enum RecordFailureSpyController: SpyController {
        public static let rootSpyableClass: AnyClass = XCTestCase.self
        public static let vector = SpyVector.direct
        public static let coselectors = SpyCoselectors(
            methodType: .instance,
            original: recordFailureOriginalSelector,
            spy: #selector(XCTestCase.spy_recordFailure(withDescription:inFile:atLine:expected:))
        )
        public static let evidence: Set<SpyEvidenceReference> = [
            RecordFailureEvidenceReferences.called,
            RecordFailureEvidenceReferences.description,
            RecordFailureEvidenceReferences.file,
            RecordFailureEvidenceReferences.line,
            RecordFailureEvidenceReferences.expected
        ]
    }

    fileprivate enum RecordFailureEvidenceReferences {
        private static let calledString = UUIDKeyString()
        private static let calledKey = ObjectAssociationKey(calledString)
        static let called = SpyEvidenceReference(key: calledKey)

        private static let descriptionString = UUIDKeyString()
        private static let descriptionKey = ObjectAssociationKey(descriptionString)
        static let description = SpyEvidenceReference(key: descriptionKey)

        private static let fileString = UUIDKeyString()
        private static let fileKey = ObjectAssociationKey(fileString)
        static let file = SpyEvidenceReference(key: fileKey)

        private static let lineString = UUIDKeyString()
        private static let lineKey = ObjectAssociationKey(lineString)
        static let line = SpyEvidenceReference(key: lineKey)

        private static let expectedString = UUIDKeyString()
        private static let expectedKey = ObjectAssociationKey(expectedString)
        static let expected = SpyEvidenceReference(key: expectedKey)
    }

    private static let recordFailureOriginalSelector =
        #selector(XCTestCase.recordFailure(withDescription:inFile:atLine:expected:))

    dynamic func spy_recordFailure(
        withDescription description: String,
        inFile filePath: String,
        atLine lineNumber: UInt,
        expected: Bool
        ) {

        recordFailureWasCalled = true
        recordFailureDescription = description
        recordFailureFile = filePath
        recordFailureLine = lineNumber
        recordFailureExpected = expected
    }

}


/// Evidence

extension XCTestCase {

    fileprivate(set) var recordFailureWasCalled: Bool {
        get {
            return loadEvidence(with: RecordFailureEvidenceReferences.called) as? Bool ?? false
        }
        set {
            let reference = RecordFailureEvidenceReferences.called
            guard newValue else {
                return removeEvidence(with: reference)
            }

            saveEvidence(true, with: reference)
        }
    }

    fileprivate(set) var recordFailureDescription: String? {
        get {
            return loadEvidence(with: RecordFailureEvidenceReferences.description) as? String
        }
        set {
            let reference = RecordFailureEvidenceReferences.description
            guard let description = newValue else {
                return removeEvidence(with: reference)
            }

            saveEvidence(description, with: reference)
        }
    }

    fileprivate(set) var recordFailureFile: String? {
        get {
            return loadEvidence(with: RecordFailureEvidenceReferences.file) as? String
        }
        set {
            let reference = RecordFailureEvidenceReferences.file
            guard let file = newValue else {
                return removeEvidence(with: reference)
            }

            saveEvidence(file, with: reference)
        }
    }

    fileprivate(set) var recordFailureLine: UInt? {
        get {
            return loadEvidence(with: RecordFailureEvidenceReferences.line) as? UInt
        }
        set {
            let reference = RecordFailureEvidenceReferences.line
            guard let line = newValue else {
                return removeEvidence(with: reference)
            }

            saveEvidence(line, with: reference)
        }
    }

    fileprivate(set) var recordFailureExpected: Bool? {
        get {
            return loadEvidence(with: RecordFailureEvidenceReferences.expected) as? Bool
        }
        set {
            let reference = RecordFailureEvidenceReferences.expected
            guard let expected = newValue else {
                return removeEvidence(with: reference)
            }

            saveEvidence(expected, with: reference)
        }
    }

}
