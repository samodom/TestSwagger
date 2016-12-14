//
//  SpyablePersistedEvidenceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import TestSwagger

class SpyablePersistedEvidenceTests: XCTestCase {

    let spyable = SampleSpyable()
    let evidence = SampleDataEvidence
    let filename: EvidenceFilename = "sample"
    let directoryName = "spy-evidence"
    var directoryUrl: URL!
    var expectedFileUrl: URL!
    let fileManager = FileManager.default

    override func setUp() {
        super.setUp()

        directoryUrl = DocumentsDirectoryURL
            .appendingPathComponent(directoryName, isDirectory: true)
        expectedFileUrl = directoryUrl
            .appendingPathComponent(filename, isDirectory: false)
    }

    override func tearDown() {
        try? fileManager.removeItem(at: expectedFileUrl)
        try? fileManager.removeItem(at: directoryUrl)

        super.tearDown()
    }

    func testPersistingDataEvidence() {
        spyable.persistDataEvidence(evidence, named: filename)

        var isDirectory: ObjCBool = false
        guard fileManager.fileExists(atPath: directoryUrl.path,
                                     isDirectory: &isDirectory)
            else {
                return XCTFail("The evidence directory should be created if it does not exist")
        }

        guard isDirectory.boolValue else {
            return XCTFail("The evidence URL is not a directory")
        }

        guard fileManager.fileExists(atPath: expectedFileUrl.path) else {
            return XCTFail("The evidence file should exist after serialization")
        }

        guard let contents = try? Data(contentsOf: expectedFileUrl) else {
            return XCTFail("The evidence file should contain data")
        }

        XCTAssertEqual(contents, evidence, "The captured evidence should be persisted to file")
    }

    func testRetrievingPersistedDataEvidence() {
        createDataFile()
        let storedEvidence = spyable.retrievePersistedDataEvidence(named: filename)
        XCTAssertEqual(storedEvidence, evidence, "The stored data evidence should be retrieved")
    }

    func testClearingPersistedDataEvidence() {
        createDataFile()

        spyable.clearPersistedEvidence(named: filename)

        XCTAssertFalse(fileManager.fileExists(atPath: expectedFileUrl.path),
                       "The evidence file should have been deleted")
        XCTAssertFalse(fileManager.fileExists(atPath: directoryUrl.path),
                       "The evidence directory should have been deleted")
    }

    func testEvidenceDirectoryNotRemovedWithRemainingEvidence() {
        createDataFile()

        let additionalFileUrl = directoryUrl.appendingPathComponent("fool's gold")
        fileManager.createFile(atPath: additionalFileUrl.path, contents: nil, attributes: nil)

        spyable.clearPersistedEvidence(named: filename)
        XCTAssertTrue(fileManager.fileExists(atPath: directoryUrl.path),
                      "The evidence directory should not have been deleted since it is not empty")
        XCTAssertTrue(fileManager.fileExists(atPath: additionalFileUrl.path),
                      "The additional file should still exist")
    }

}


fileprivate extension SpyablePersistedEvidenceTests {

    func createDataFile() {
        createEvidenceDirectoryIfNeeded()
        fileManager.createFile(atPath: expectedFileUrl.path, contents: evidence, attributes: nil)
    }

    private func createEvidenceDirectoryIfNeeded() {
        guard !fileManager.fileExists(atPath: directoryUrl.path) else { return }

        try! fileManager.createDirectory(
            at: directoryUrl,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }

}
