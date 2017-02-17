//
//  CodeSource.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/15/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import Foundation

/// Type for capturing the filename and line of some code.
public struct CodeSource {

    /// The filename of the file containing the code.
    public let file: String


    /// The line number of the code.
    public let line: UInt


    /// Creates a new code source value
    /// - parameter file: The filename of the file containing the code.
    /// - parameter line: /// The line number of the code.
    public init(file: String, line: UInt) {
        self.file = file
        self.line = line
    }

}
