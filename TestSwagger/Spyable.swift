//
//  Spyable.swift
//  TestSwagger
//
//  Created by Sam Odom on 12/11/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

import FoundationSwagger

/// A protocol for classes with methods and/or properties upon which one would like to spy.
public protocol Spyable: class, ObjectAssociating {}
