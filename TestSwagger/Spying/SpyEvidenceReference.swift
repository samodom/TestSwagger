//
//  SpyEvidenceReference.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/2/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import FoundationSwagger


/// Common type for retrieving and manipulating spy evidence.
public enum SpyEvidenceReference {

    /// Used for object association.
    case association(ObjectAssociationKey)

    /// Used for object serialization.
    case serialization(URL)

}


/// Equatable and hashable implementations for set inclusion.
extension SpyEvidenceReference: Equatable {}

public func ==(lhs: SpyEvidenceReference, rhs: SpyEvidenceReference) -> Bool {
    switch (lhs, rhs) {
    case (.association(let leftKey), .association(let rightKey)):
        return leftKey == rightKey

    case (.serialization(let leftUrl), .serialization(let rightUrl)):
        return leftUrl == rightUrl

    default:
        return false
    }
}

extension SpyEvidenceReference: Hashable {

    public var hashValue: Int {
        switch self {
        case .association(let key):
            return key.hashValue

        case .serialization(let url):
            return url.hashValue
        }
    }

}
