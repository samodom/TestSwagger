//
//  MethodForwardingBehaviorTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 2/17/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest
import TestSwagger


class MethodForwardingBehaviorTests: XCTestCase {

    var behavior: MethodForwardingBehavior!

    func testAllCases() {
        behavior = .always
        switch behavior! {
        case .always, .never, .custom(_):
            break
        }
    }

    func testAlwaysCase() {
        XCTAssertTrue(MethodForwardingBehavior.always.forwards,
                      "The 'always' case should represent always forwarding method calls")
    }

    func testNeverCase() {
        XCTAssertFalse(MethodForwardingBehavior.never.forwards,
                       "The 'never' case should represent never forwarding method calls")
    }

    func testCustomCase() {
        XCTAssertTrue(MethodForwardingBehavior.custom(true).forwards,
                      "The 'custom' case should allow custom forwarding of method calls")
        XCTAssertFalse(MethodForwardingBehavior.custom(false).forwards,
                       "The 'custom' case should allow custom forwarding of method calls")
    }

}
