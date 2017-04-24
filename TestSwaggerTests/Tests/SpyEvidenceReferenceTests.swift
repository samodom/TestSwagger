//
//  SpyEvidenceReferenceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/3/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import TestSwagger


class SpyEvidenceReferenceTests: XCTestCase {

    let sampleKeyString = UUIDKeyString()
    var sampleKey: ObjectAssociationKey!
    var sampleAssociation: SpyEvidenceReference!

    let samplePath = DocumentsDirectoryURL.appendingPathComponent("sample/sample").path
    var sampleSerialization: SpyEvidenceReference!

    let alternatePath = DocumentsDirectoryURL.appendingPathComponent("sample/../sample/sample").path
    var alternateSerialization: SpyEvidenceReference!

    override func setUp() {
        super.setUp()

        sampleKey = ObjectAssociationKey(sampleKeyString)
        sampleAssociation = .association(key: sampleKey)
        sampleSerialization = .serialization(path: samplePath)
        alternateSerialization = .serialization(path: alternatePath)
    }

    func testSpyEvidenceReferenceCases() {
        switch sampleAssociation! {
        case .association(_),
             .serialization(_):
            break
        }
    }

    func testCreatingAssociationReference() {
        let reference = SpyEvidenceReference(key: sampleKey)
        switch reference {
        case .association(let key):
            XCTAssertEqual(key, sampleKey, "Should be able to create a reference with a key")
        default:
            XCTFail("Invalid reference created when using an object association key")
        }
    }

    func testCreatingSerializationReference() {
        let reference = SpyEvidenceReference(path: samplePath)
        switch reference {
        case .serialization(let path):
            XCTAssertEqual(path, samplePath, "Should be able to create a reference with a string path")
        default:
            XCTFail("Invalid reference created when using a file path")
        }
    }

    func testAssociationEquatability() {
        let sameAssociation = SpyEvidenceReference.association(key: sampleKey)
        let otherKeyString = UUIDKeyString()
        let otherKey = ObjectAssociationKey(otherKeyString)
        let otherAssociation = SpyEvidenceReference.association(key: otherKey)

        XCTAssertEqual(sampleAssociation, sameAssociation,
                       "Association references with equal keys should be equal")
        XCTAssertNotEqual(sampleAssociation, otherAssociation,
                          "Association references with unequal keys should be unequal")
    }

    func testSerializationEquatability() {
        let sameSerialization = SpyEvidenceReference(path: samplePath)
        let otherPath = DocumentsDirectoryURL.appendingPathComponent("other/other").path
        let otherSerialization = SpyEvidenceReference(path: otherPath)

        XCTAssertEqual(sampleSerialization, sameSerialization,
                       "Serialization references with equal paths should be equal")
        XCTAssertEqual(sampleSerialization, alternateSerialization,
                       "Serialization references with paths to the same file should be equal")
        XCTAssertNotEqual(sampleSerialization, otherSerialization,
                          "Serialization references with unequal paths should be unequal")
    }

    func testMismatchedReferenceTypesAreUnequal() {
        XCTAssertNotEqual(sampleAssociation, sampleSerialization,
                          "Association references and serialization references should never be equal")
    }

    func testReferenceHashability() {
        XCTAssertEqual(sampleAssociation.hashValue, sampleKey.hashValue,
                       "Association references should use their key's hash value")
        XCTAssertEqual(sampleSerialization.hashValue, samplePath.hashValue,
                       "Serialization references should use their standardized path's hash value")
        XCTAssertEqual(sampleSerialization.hashValue, samplePath.hashValue,
                       "Serialization references should use their standardized path's hash value")
    }

}
