//
//  SpyEvidenceTestCase.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/13/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import FoundationSwagger
import TestSwagger


class SpyEvidenceTestCase: XCTestCase {

    private let keyString = UUIDKeyString()
    var key: ObjectAssociationKey!
    var associationReference: SpyEvidenceReference!

    let goodPath = DocumentsDirectoryURL.appendingPathComponent("sampleEvidence").path
    var goodSerializationReference: SpyEvidenceReference!

    let badPath = "http://www.example.com/"
    var badSerializationReference: SpyEvidenceReference!

    let sampleEvidence = "Celiac cornhole vice vegan unicorn umami kale chips forage four dollar"
    var storedValue: String!


    override func setUp() {
        super.setUp()

        key = ObjectAssociationKey(keyString)
        associationReference = SpyEvidenceReference(key: key)

        goodSerializationReference = SpyEvidenceReference(path: goodPath)
        badSerializationReference = SpyEvidenceReference(path: badPath)
    }

}
