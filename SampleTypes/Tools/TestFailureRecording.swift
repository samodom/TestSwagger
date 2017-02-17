//
//  TestFailureRecording.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/15/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest

public extension XCTestCase {

    /// Convenience method for recording test failures that simply calls the system-provided method.
    /// - parameter description: User-facing message describing the test failure.
    /// - parameter codeSource: The location of the code with the failing test invocation.
    /// - parameter expected: Indicates whether or not the failure was due to a failing assertion.
    public func recordFailure(
        withDescription description: String,
        at codeSource: CodeSource,
        expected: Bool = true
        ) {

        recordFailure(
            withDescription: description,
            inFile: codeSource.file,
            atLine: codeSource.line,
            expected: expected
        )
    }
    
}
