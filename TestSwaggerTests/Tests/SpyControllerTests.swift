//
//  SpyControllerTests.swift
//  TestSwagger
//
//  Created by Sam Odom on 1/8/17.
//  Copyright © 2017 Swagger Soft. All rights reserved.
//

import XCTest

class SpyControllerTests: SpyControllerTestCase {

    // MARK: - THIS IS THE BIG TEST!!!
    func testAllSpyVariants() {
        SpyTestVariant.allVariants.forEach {
            runSpyControllerTests(for: $0)
        }
    }

}
