//
//  ObjectSpyEvidenceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/13/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import SampleTypes
import TestSwagger


class ObjectSpyEvidenceTests: SpyEvidenceTestCase {

    let spyableObjects: [SpyableObject] = [
        SwiftRootSpyable(),
        ObjectiveCRootSpyable()
    ]

    override func tearDown() {
        spyableObjects.forEach { $0.removeAllAssociations() }
        try? FileManager.default.removeItem(atPath: goodPath)

        super.tearDown()
    }

    func testSavingAssociatedEvidence() {
        spyableObjects.forEach { object in
            object.saveEvidence(sampleEvidence, with: associationReference)
            XCTAssertEqual(object.stringAssociation(for: key), sampleEvidence,
                           "Spyable objects should store evidence through object association")
            object.removeAllAssociations()
        }
    }

    func testFailingToSavePersistedEvidence() {
        spyableObjects.forEach { object in
            object.saveEvidence(sampleEvidence, with: badSerializationReference)
        }
    }

    func testSavingPersistedEvidence() {
        spyableObjects.forEach { object in
            object.saveEvidence(sampleEvidence, with: goodSerializationReference)
            storedValue = NSKeyedUnarchiver.unarchiveObject(withFile: goodPath) as? String
            XCTAssertEqual(storedValue, sampleEvidence,
                           "Spyable objects should store evidence through object serialization")
            try! FileManager.default.removeItem(atPath: goodPath)
        }
    }

    func testLoadingAssociatedEvidence() {
        spyableObjects.forEach { object in
            object.associate(sampleEvidence, with: key)
            storedValue = object.loadEvidence(with: associationReference) as? String
            XCTAssertEqual(storedValue, sampleEvidence,
                           "Associated evidence should be retrievable by reference")
            object.removeAllAssociations()
        }
    }

    func testFailingToLoadPersistedEvidence() {
        spyableObjects.forEach { object in
            XCTAssertNil(object.loadEvidence(with: badSerializationReference),
                         "Loading serialized data with invalid reference paths should not throw an error")
        }
    }

    func testLoadingPersistedEvidence() {
        NSKeyedArchiver.archiveRootObject(sampleEvidence, toFile: goodPath)
        spyableObjects.forEach { object in
            storedValue = object.loadEvidence(with: goodSerializationReference) as? String
            XCTAssertEqual(storedValue, sampleEvidence,
                           "Serialized evidence should be retrievable by reference")
        }
        try! FileManager.default.removeItem(atPath: goodPath)
    }

    func testRemovingAssociatedEvidence() {
        spyableObjects.forEach { object in
            object.associate(sampleEvidence, with: key)
            object.removeEvidence(with: associationReference)
            XCTAssertNil(objc_getAssociatedObject(object, key),
                         "Associated evidence should be removable by reference")
        }
    }

    func testFailingToRemovePersistedEvidence() {
        spyableObjects.forEach { object in
            object.removeEvidence(with: badSerializationReference)
        }
    }
    
    func testRemovingPersistedEvidence() {
        let fileManager = FileManager.default
        NSKeyedArchiver.archiveRootObject(sampleEvidence, toFile: goodPath)
        spyableObjects.forEach { object in
            object.removeEvidence(with: goodSerializationReference)
            XCTAssertFalse(fileManager.fileExists(atPath: goodPath),
                           "Serialized evidence should be retrievable by reference")
        }
    }

}
