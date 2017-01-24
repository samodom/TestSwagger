
//
//  SpyableTestCase.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/13/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import TestSwagger


class SpyableTestCase: XCTestCase {

    let fileManager = FileManager.default

    let sampleStringEvidence = "Celiac cornhole vice vegan unicorn umami kale chips forage four dollar"
    var sampleDataEvidence: Data!

    private let expectedEvidenceDirectoryName = "spy-evidence"
    var expectedEvidenceDirectoryUrl: URL!

    let sampleEvidenceFilename: SpyEvidenceFilename = "sample"
    var sampleEvidenceUrl: URL!

    private let sampleKeyString = UUIDKeyString()
    var sampleKey: ObjectAssociationKey!

    let sampleSpyable = SwiftRootSpyable()

    override func setUp() {
        super.setUp()

        sampleDataEvidence = sampleStringEvidence.data(using: .utf8)!
        expectedEvidenceDirectoryUrl = DocumentsDirectoryURL
            .appendingPathComponent(expectedEvidenceDirectoryName, isDirectory: true)
        sampleEvidenceUrl = expectedEvidenceDirectoryUrl
            .appendingPathComponent(sampleEvidenceFilename, isDirectory: false)
        sampleKey = ObjectAssociationKey(sampleKeyString)
    }

    override func tearDown() {
        try? fileManager.removeItem(at: sampleEvidenceUrl)
        try? fileManager.removeItem(at: expectedEvidenceDirectoryUrl)

        super.tearDown()
    }

    func createSampleDataEvidenceFile() {
        createEvidenceDirectoryIfNeeded()
        fileManager.createFile(
            atPath: sampleEvidenceUrl.path,
            contents: sampleDataEvidence,
            attributes: nil
        )
    }

    private func createEvidenceDirectoryIfNeeded() {
        guard !fileManager.fileExists(atPath: expectedEvidenceDirectoryUrl.path)
            else { return }

        try! fileManager.createDirectory(
            at: expectedEvidenceDirectoryUrl,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }

}
