//
//  Spyable.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//


public protocol Spyable: class {}

public extension Spyable {

    /// Persists raw data to a spy evidence directory using the provided filename
    /// - parameter evidence: Raw data to persist to file as evidence.
    /// - parameter named: Filename to use for the persisted data.
    public func persistDataEvidence(_ evidence: Data, named filename: EvidenceFilename) {
        ensureIntermediateDirectoriesExist()

        let url = evidenceFileUrl(for: filename)
        do {
            try evidence.write(to: url)
        }
        catch {
            fatalError("Unable to create evidence file at path: \(url.path)")
        }
    }


    /// Retrieves data persisted as spy evidence.
    /// - parameter named: Filename for file storing persisted data.
    /// - returns: Data stored in file with provided filename, if it exists.
    public func retrievePersistedDataEvidence(named filename: EvidenceFilename) -> Data? {
        do {
            return try Data(contentsOf: evidenceFileUrl(for: filename))
        }
        catch {
            print("No evidence found with filename: \(filename)")
            return nil
        }
    }


    /// Removes a persisted spy evidencefiles.
    /// - parameter named: Filename for file storing persisted spy evidence.
    public func clearPersistedEvidence(named filename: EvidenceFilename) {
        let url = evidenceFileUrl(for: filename)
        do {
            defer { removeEvidenceDirectoryIfEmpty() }

            try FileManager.default.removeItem(at: url)
        }
        catch {
            fatalError("Unable to remove evidence file at path \(url.path): \(error)")
        }
    }

}


fileprivate extension Spyable {

    func evidenceFileUrl(for filename: EvidenceFilename) -> URL {
        return EvidenceDirectoryUrl.appendingPathComponent(filename)
    }

    func ensureIntermediateDirectoriesExist() {
        do {
            let fileManager = FileManager.default
            let url = EvidenceDirectoryUrl

            guard !fileManager.fileExists(atPath: url.path) else { return }

            try FileManager.default.createDirectory(
                at: url,
                withIntermediateDirectories: true,
                attributes: nil
            )
        }
        catch {
            fatalError("Unable to create evidence directory on file system: \(error)")
        }
    }

    func removeEvidenceDirectoryIfEmpty() {
        do {
            let fileManager = FileManager.default
            let contents = try fileManager.contentsOfDirectory(atPath: EvidenceDirectoryUrl.path)

            guard contents.isEmpty else {
                return
            }

            try FileManager.default.removeItem(at: EvidenceDirectoryUrl)
        }
        catch {
            fatalError("Unable to remove spy evidence directory: \(error)")
        }
    }

}
