//
//  SpyableEvidencePersistenceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import TestSwagger

class SpyableEvidencePersistenceTests: SpyableTestCase {

    func testPersistingDataEvidence() {
        sampleSpyable.persistDataEvidence(sampleDataEvidence, named: sampleEvidenceFilename)

        var isDirectory: ObjCBool = false
        guard fileManager.fileExists(atPath: expectedEvidenceDirectoryUrl.path,
                                     isDirectory: &isDirectory)
            else {
                return XCTFail("The evidence directory should be created if it does not exist")
        }

        guard isDirectory.boolValue else {
            return XCTFail("The evidence URL is not a directory")
        }

        guard fileManager.fileExists(atPath: sampleEvidenceUrl.path) else {
            return XCTFail("The evidence file should exist after serialization")
        }

        guard let contents = try? Data(contentsOf: sampleEvidenceUrl) else {
            return XCTFail("The evidence file should contain data")
        }

        XCTAssertEqual(contents, sampleDataEvidence, "The captured evidence should be persisted to file")
    }

    func testRetrievingPersistedDataEvidence() {
        createSampleDataEvidenceFile()
        let storedEvidence = sampleSpyable.retrievePersistedDataEvidence(named: sampleEvidenceFilename)
        XCTAssertEqual(storedEvidence, sampleDataEvidence, "The stored data evidence should be retrieved")
    }

    func testClearingPersistedDataEvidence() {
        createSampleDataEvidenceFile()

        sampleSpyable.clearPersistedEvidence(named: sampleEvidenceFilename)

        XCTAssertFalse(fileManager.fileExists(atPath: sampleEvidenceUrl.path),
                       "The evidence file should have been deleted")
        XCTAssertFalse(fileManager.fileExists(atPath: expectedEvidenceDirectoryUrl.path),
                       "The evidence directory should have been deleted")
    }

    func testEvidenceDirectoryNotRemovedWithRemainingEvidence() {
        createSampleDataEvidenceFile()

        let additionalFileUrl = expectedEvidenceDirectoryUrl.appendingPathComponent("fool's gold")
        fileManager.createFile(atPath: additionalFileUrl.path, contents: nil, attributes: nil)

        sampleSpyable.clearPersistedEvidence(named: sampleEvidenceFilename)
        XCTAssertTrue(fileManager.fileExists(atPath: expectedEvidenceDirectoryUrl.path),
                      "The evidence directory should not have been deleted since it is not empty")
        XCTAssertTrue(fileManager.fileExists(atPath: additionalFileUrl.path),
                      "The additional file should still exist")
    }

}
