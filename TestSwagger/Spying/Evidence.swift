//
//  Evidence.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger

/// Function that provides unique content that can be used to create object association keys.
/// - returns: A C-string representing a universally unique identifier.
public func UUIDKeyString() -> [CChar] {
    return NSUUID().uuidString.cString(using: .utf8)!
}


public extension SpyableObject {

    /// Saves spy evidence.
    /// - parameter evidence: Evidence to save.
    /// - parameter with: Evidence reference used to save evidence.
    public func saveEvidence(_ evidence: Any, with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            associate(evidence, with: key)

        case .serialization(path: let path):
            NSKeyedArchiver.archiveRootObject(evidence, toFile: path)
        }
    }


    /// Retrieves saved spy evidence.
    /// - parameter with: Evidence reference pointing to saved evidence.
    /// - returns: Data evidence stored in file with provided path, if it exists.
    public func loadEvidence(with reference: SpyEvidenceReference) -> Any? {
        switch reference {
        case .association(key: let key):
            return association(for: key)

        case .serialization(path: let path):
            return NSKeyedUnarchiver.unarchiveObject(withFile: path)
        }
    }


    /// Removes spy evidence.
    /// - parameter with: Evidence referencing pointing to spy evidence.
    public func removeEvidence(with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            removeAssociation(for: key)

        case .serialization(path: let path):
            try? FileManager.default.removeItem(atPath: path)
        }
    }

}


public extension SpyableClass {

    /// Saves spy evidence.
    /// - parameter evidence: Evidence to save.
    /// - parameter with: Evidence reference used to save evidence.
    public static func saveEvidence(_ evidence: Any, with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            associate(evidence, with: key)

        case .serialization(path: let path):
            NSKeyedArchiver.archiveRootObject(evidence, toFile: path)
        }
    }


    /// Retrieves saved spy evidence.
    /// - parameter with: Evidence reference pointing to saved evidence.
    /// - returns: Data evidence stored in file with provided path, if it exists.
    public static func loadEvidence(with reference: SpyEvidenceReference) -> Any? {
        switch reference {
        case .association(key: let key):
            return association(for: key)

        case .serialization(path: let path):
            return NSKeyedUnarchiver.unarchiveObject(withFile: path)
        }
    }


    /// Removes spy evidence.
    /// - parameter with: Evidence referencing pointing to spy evidence.
    public static func removeEvidence(with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            removeAssociation(for: key)

        case .serialization(path: let path):
            try? FileManager.default.removeItem(atPath: path)
        }
    }
    
}
