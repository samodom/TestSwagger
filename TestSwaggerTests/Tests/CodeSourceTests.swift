//
//  CodeSourceTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/15/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger

class CodeSourceTests: XCTestCase {

    let codeSource = CodeSource(file: "sampleFilename", line: 42)
    let sampleMessage = "Sample test failure message"

    func testCreatingCodeSource() {
        XCTAssertEqual(codeSource.file, "sampleFilename", "A code source should capture a filename")
        XCTAssertEqual(codeSource.line, 42, "A code source should capture a line number")
    }

    func testRecordingExpectedTestFailureWithCodeSource() {
        let spy = XCTestCase.RecordFailureSpyController.createSpy(on: self)!
        spy.spy {
            recordFailure(
                withDescription: sampleMessage,
                at: codeSource
            )

            XCTAssertTrue(recordFailureWasCalled,
                          "The original failure-recording method should be called")
            XCTAssertEqual(recordFailureDescription, sampleMessage,
                           "The failure description should be passed to the original method")
            XCTAssertEqual(recordFailureFile, codeSource.file,
                           "The failing source file should be passed to the original method")
            XCTAssertEqual(recordFailureLine, codeSource.line,
                           "The failing source line should be passed to the original method")
            XCTAssertTrue(recordFailureExpected!,
                           "The failure should default to an expected failure")
        }
    }

    func testRecordingUnexpectedTestFailureWithCodeSource() {
        let spy = XCTestCase.RecordFailureSpyController.createSpy(on: self)!
        spy.spy {
            recordFailure(
                withDescription: sampleMessage,
                at: codeSource,
                expected: false
            )

            XCTAssertTrue(recordFailureWasCalled,
                          "The original failure-recording method should be called")
            XCTAssertEqual(recordFailureDescription, sampleMessage,
                           "The failure description should be passed to the original method")
            XCTAssertEqual(recordFailureFile, codeSource.file,
                           "The failing source file should be passed to the original method")
            XCTAssertEqual(recordFailureLine, codeSource.line,
                           "The failing source line should be passed to the original method")
            XCTAssertFalse(recordFailureExpected!,
                          "The failure expectation flag should be passed to the original method")
        }
    }

}
