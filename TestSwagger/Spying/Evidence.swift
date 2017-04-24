//
//  Evidence.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger

public extension ObjectSpyable {

    /// Saves spy evidence.
    /// - parameter evidence: Evidence to save.
    /// - parameter reference: Evidence reference used to save evidence.
    public func saveEvidence(_ evidence: Any, with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            associate(evidence, with: key)

        case .serialization(path: let path):
            NSKeyedArchiver.archiveRootObject(evidence, toFile: path)
        }
    }


    /// Retrieves saved spy evidence.
    /// - parameter reference: Evidence reference pointing to saved evidence.
    /// - returns: Evidence saved with the provided reference, if it exists.
    public func loadEvidence(with reference: SpyEvidenceReference) -> Any? {
        switch reference {
        case .association(key: let key):
            return association(for: key)

        case .serialization(path: let path):
            return NSKeyedUnarchiver.unarchiveObject(withFile: path)
        }
    }


    /// Removes spy evidence.
    /// - parameter reference: Evidence referencing pointing to spy evidence.
    public func removeEvidence(with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            removeAssociation(for: key)

        case .serialization(path: let path):
            try? FileManager.default.removeItem(atPath: path)
        }
    }

}


public extension ClassSpyable {

    /// Saves spy evidence.
    /// - parameter evidence: Evidence to save.
    /// - parameter reference: Evidence reference used to save evidence.
    public static func saveEvidence(_ evidence: Any, with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            associate(evidence, with: key)

        case .serialization(path: let path):
            NSKeyedArchiver.archiveRootObject(evidence, toFile: path)
        }
    }


    /// Retrieves saved spy evidence.
    /// - parameter reference: Evidence reference pointing to saved evidence.
    /// - returns: Evidence saved with the provided reference, if it exists.
    public static func loadEvidence(with reference: SpyEvidenceReference) -> Any? {
        switch reference {
        case .association(key: let key):
            return association(for: key)

        case .serialization(path: let path):
            return NSKeyedUnarchiver.unarchiveObject(withFile: path)
        }
    }


    /// Removes spy evidence.
    /// - parameter reference: Evidence referencing pointing to spy evidence.
    public static func removeEvidence(with reference: SpyEvidenceReference) {
        switch reference {
        case .association(key: let key):
            removeAssociation(for: key)

        case .serialization(path: let path):
            try? FileManager.default.removeItem(atPath: path)
        }
    }
    
}
