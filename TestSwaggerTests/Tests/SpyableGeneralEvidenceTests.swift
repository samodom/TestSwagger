//
//  SpyableGeneralEvidenceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/13/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import FoundationSwagger
import TestSwagger


class SpyableGeneralEvidenceTests: SpyableTestCase {

    func testUUIDKeyStringKeyUniqueness() {
        let stringKeys = (1...100).map { _ in
            UUIDKeyString()
        }

        let keyPointers = stringKeys.map { ObjectAssociationKey($0) }
        let uniquePointers = Set(keyPointers)

        XCTAssertEqual(uniquePointers.count, keyPointers.count, "Each pointer should be unique")
    }

    func testClearingObjectAssociationSpyEvidence() {
        sampleSpyable.associate(sampleStringEvidence, with: sampleKey)
        sampleSpyable.persistDataEvidence(sampleDataEvidence, named: sampleEvidenceFilename)

        sampleSpyable.clearCapturedSpyEvidence(for: [sampleKey])
        XCTAssertNil(sampleSpyable.association(for: sampleKey),
                     "The object association should be cleared")
    }

    func testClearingPersistedSpyEvidence() {
        sampleSpyable.associate(sampleStringEvidence, with: sampleKey)
        sampleSpyable.persistDataEvidence(sampleDataEvidence, named: sampleEvidenceFilename)

        sampleSpyable.clearCapturedSpyEvidence(for: [sampleEvidenceFilename])
        XCTAssertNil(sampleSpyable.retrievePersistedDataEvidence(named: sampleEvidenceFilename),
                     "The persisted evidence should be cleared")
    }

}
