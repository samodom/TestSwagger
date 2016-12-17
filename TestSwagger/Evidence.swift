//
//  Evidence.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger


/// Type alias for using strings to represent filenames for persisted spy evidence.
public typealias SpyEvidenceFilename = String


/// Function that provides unique content that can be used to create object association keys.
/// - returns: A C-string representing a universally-unique identifier.
public func UUIDKeyString() -> [CChar] {
    return NSUUID().uuidString.cString(using: .utf8)!
}


public extension Spyable {

    /// Clears all spy evidence captured via associated objects and file serialization.
    /// - parameter for: A set of keys potentially being used to refer to captured spy evidence.
    public func clearCapturedSpyEvidence(for keys: Set<ObjectAssociationKey>) {
        keys.forEach {
            removeAssociation(for: $0)
        }
    }

}
