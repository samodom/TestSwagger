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

    /// Type of reference used for object association.
    case association(key: ObjectAssociationKey)


    /// Type of reference used for object serialization.
    case serialization(path: String)


    /// Convenience initializer for creating an association evidence reference.
    public init(key: ObjectAssociationKey) {
        self = .association(key: key)
    }


    /// Convenience initializer for creating a serialization evidence reference.
    public init(path: String) {
        self = .serialization(path: path)
    }

}


/// Equatable and hashable implementations for set inclusion.
extension SpyEvidenceReference: Equatable {}

public func ==(lhs: SpyEvidenceReference, rhs: SpyEvidenceReference) -> Bool {
    switch (lhs, rhs) {
    case (.association(let leftKey), .association(let rightKey)):
        return leftKey == rightKey

    case (.serialization(let leftPath), .serialization(let rightPath)):
        return URL(fileURLWithPath: leftPath).standardizedFileURL.path ==
            URL(fileURLWithPath: rightPath).standardizedFileURL.path

    default:
        return false
    }
}

extension SpyEvidenceReference: Hashable {

    public var hashValue: Int {
        switch self {
        case .association(let key):
            return key.hashValue

        case .serialization(let locator):
            return locator.hashValue
        }
    }

}
