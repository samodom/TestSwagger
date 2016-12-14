//
//  Evidence.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger

/// Type alias for using strings to represent filenames
public typealias EvidenceFilename = String


private let EvidenceDirectoryName = "spy-evidence"
let EvidenceDirectoryUrl = DocumentsDirectoryURL
    .appendingPathComponent(EvidenceDirectoryName, isDirectory: true)
