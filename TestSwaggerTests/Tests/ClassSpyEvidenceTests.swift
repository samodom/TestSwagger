//
//  ClassSpyEvidenceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/13/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import TestSwagger


class ClassSpyEvidenceTests: SpyEvidenceTestCase {

    let spyableClasses: [SpyableClass.Type] = [
        SwiftRootSpyable.self,
        ObjectiveCRootSpyable.self
    ]

    override func tearDown() {
        spyableClasses.forEach { $0.removeAllAssociations() }
        try? FileManager.default.removeItem(atPath: goodPath)

        super.tearDown()
    }

    func testSavingAssociatedEvidence() {
        spyableClasses.forEach { `class` in
            `class`.saveEvidence(sampleEvidence, with: associationReference)
            XCTAssertEqual(`class`.stringAssociation(for: key), sampleEvidence,
                           "Spyable objects should store evidence through object association")
            `class`.removeAllAssociations()
        }
    }

    func testFailingToSavePersistedEvidence() {
        spyableClasses.forEach { `class` in
            `class`.saveEvidence(sampleEvidence, with: badSerializationReference)
        }
    }

    func testSavingPersistedEvidence() {
        spyableClasses.forEach { `class` in
            `class`.saveEvidence(sampleEvidence, with: goodSerializationReference)
            storedValue = NSKeyedUnarchiver.unarchiveObject(withFile: goodPath) as? String
            XCTAssertEqual(storedValue, sampleEvidence,
                           "Spyable objects should store evidence through object serialization")
            try! FileManager.default.removeItem(atPath: goodPath)
        }
    }

    func testLoadingAssociatedEvidence() {
        spyableClasses.forEach { `class` in
            `class`.associate(sampleEvidence, with: key)
            storedValue = `class`.loadEvidence(with: associationReference) as? String
            XCTAssertEqual(storedValue, sampleEvidence,
                           "Associated evidence should be retrievable by reference")
            `class`.removeAllAssociations()
        }
    }

    func testFailingToLoadPersistedEvidence() {
        spyableClasses.forEach { `class` in
            XCTAssertNil(`class`.loadEvidence(with: badSerializationReference),
                         "Loading serialized data with invalid reference paths should not throw an error")
        }
    }

    func testLoadingPersistedEvidence() {
        NSKeyedArchiver.archiveRootObject(sampleEvidence, toFile: goodPath)
        spyableClasses.forEach { `class` in
            storedValue = `class`.loadEvidence(with: goodSerializationReference) as? String
            XCTAssertEqual(storedValue, sampleEvidence,
                           "Serialized evidence should be retrievable by reference")
        }
        try! FileManager.default.removeItem(atPath: goodPath)
    }

    func testRemovingAssociatedEvidence() {
        spyableClasses.forEach { `class` in
            `class`.associate(sampleEvidence, with: key)
            `class`.removeEvidence(with: associationReference)
            XCTAssertNil(objc_getAssociatedObject(`class`, key),
                         "Associated evidence should be removable by reference")
        }
    }

    func testFailingToRemovePersistedEvidence() {
        spyableClasses.forEach { `class` in
            `class`.removeEvidence(with: badSerializationReference)
        }
    }
    
    func testRemovingPersistedEvidence() {
        let fileManager = FileManager.default
        NSKeyedArchiver.archiveRootObject(sampleEvidence, toFile: goodPath)
        spyableClasses.forEach { `class` in
            `class`.removeEvidence(with: goodSerializationReference)
            XCTAssertFalse(fileManager.fileExists(atPath: goodPath),
                           "Serialized evidence should be retrievable by reference")
        }
    }

}
