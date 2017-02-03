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

    let sampleUrl = URL(string: "file:///testing/foo")!
    var sampleSerialization: SpyEvidenceReference!


    override func setUp() {
        super.setUp()

        sampleKey = ObjectAssociationKey(sampleKeyString)
        sampleAssociation = .association(sampleKey)
        sampleSerialization = .serialization(sampleUrl)
    }

    func testSpyEvidenceReferenceCases() {
        switch sampleAssociation! {
        case .association(_),
             .serialization(_):
            break
        }
    }

    func testAssociationEquatability() {
        let sameAssociation = SpyEvidenceReference.association(sampleKey)
        let otherKeyString = UUIDKeyString()
        let otherKey = ObjectAssociationKey(otherKeyString)
        let otherAssociation = SpyEvidenceReference.association(otherKey)

        XCTAssertEqual(sampleAssociation, sameAssociation,
                       "Association references with equal keys should be equal")
        XCTAssertNotEqual(sampleAssociation, otherAssociation,
                          "Association references with unequal keys should be unequal")
    }

    func testSerializationEquatability() {
        let sameSerialization = SpyEvidenceReference.serialization(sampleUrl)
        let otherUrl = URL(string: "http://www.example.com./foo")!
        let otherSerialization = SpyEvidenceReference.serialization(otherUrl)

        XCTAssertEqual(sampleSerialization, sameSerialization,
                       "Serialization references with equal URLs should be equal")
        XCTAssertNotEqual(sampleSerialization, otherSerialization,
                          "Serialization references with unequal URLs should be unequal")
    }

    func testReferenceHashability() {
        XCTAssertEqual(sampleAssociation.hashValue, sampleKey.hashValue,
                       "Association references should use their key's hash value")
        XCTAssertEqual(sampleSerialization.hashValue, sampleUrl.hashValue,
                       "Serialization references should use their URL's hash value")
    }

}
