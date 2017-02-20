//
//  SpiesCommon.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/15/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger
import TestSwagger

let SampleAssociationReference = SpyEvidenceReference(key: sampleKey)
fileprivate let sampleKeyString = UUIDKeyString()
fileprivate let sampleKey = ObjectAssociationKey(sampleKeyString)

let samplePath = TemporaryDirectoryPath.appendingFormat("sampleEvidence")
let SampleSerializationReference = SpyEvidenceReference(path: samplePath)

let SampleReferences: Set = [
    SampleAssociationReference,
    SampleSerializationReference
]


protocol SampleObjectSpyable: ObjectSpyable {}

extension SampleObjectSpyable {

    var sampleInstanceMethodCalledAssociated: Bool {
        get {
            return loadEvidence(with: SampleAssociationReference) as? Bool ?? false
        }
        set {
            guard newValue else {
                return removeEvidence(with: SampleAssociationReference)
            }

            saveEvidence(true, with: SampleAssociationReference)
        }
    }

    var sampleInstanceMethodCalledSerialized: Bool {
        get {
            return loadEvidence(with: SampleSerializationReference) as? Bool ?? false
        }
        set {
            guard newValue else {
                return removeEvidence(with: SampleSerializationReference)
            }

            saveEvidence(true, with: SampleSerializationReference)
        }
    }

}


protocol SampleClassSpyable: ClassSpyable {}

extension SampleClassSpyable {

    static var sampleClassMethodCalledAssociated: Bool {
        get {
            return loadEvidence(with: SampleAssociationReference) as? Bool ?? false
        }
        set {
            guard newValue else {
                return removeEvidence(with: SampleAssociationReference)
            }

            saveEvidence(true, with: SampleAssociationReference)
        }
    }

    static var sampleClassMethodCalledSerialized: Bool {
        get {
            return loadEvidence(with: SampleSerializationReference) as? Bool ?? false
        }
        set {
            guard newValue else {
                return removeEvidence(with: SampleSerializationReference)
            }

            saveEvidence(true, with: SampleSerializationReference)
        }
    }

}
