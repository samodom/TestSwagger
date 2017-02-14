//
//  ObjectiveCSpyables.m
//  SampleTypes
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import "ObjectiveCSpyables.h"
#import <SampleTypes/SampleTypes-Swift.h>


//  Root sample class

@implementation ObjectiveCRootSpyable

+ (NSInteger)sampleClassMethod:(NSString *)input {
    return WellKnownMethodReturnValuesDefinedAtRoot;
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    return WellKnownMethodReturnValuesDefinedAtRoot;
}

@end


// Inheriting subclasses

@implementation ObjectiveCInheritor
@end

@implementation ObjectiveCInheritorOfInheritor
@end


// Overriding subclasses

@implementation ObjectiveCOverrider

BOOL ObjectiveCOverriderCallsSuperclass = NO;

+ (NSInteger)sampleClassMethod:(NSString *)input {
    if (ObjectiveCOverriderCallsSuperclass) {
        return [super sampleClassMethod:input];
    }
    else {
        return WellKnownMethodReturnValuesOverriddenAtLevel1;
    }
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    if (ObjectiveCOverriderCallsSuperclass) {
        return [super sampleInstanceMethod:input];
    }
    else {
        return WellKnownMethodReturnValuesOverriddenAtLevel1;
    }
}

@end

@implementation ObjectiveCOverriderOfOverrider

BOOL ObjectiveCOverriderOfOverriderCallsSuperclass = NO;

+ (NSInteger)sampleClassMethod:(NSString *)input {
    if (ObjectiveCOverriderOfOverriderCallsSuperclass) {
        return [super sampleClassMethod:input];
    }
    else {
        return WellKnownMethodReturnValuesOverriddenAtLevel2;
    }
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    if (ObjectiveCOverriderOfOverriderCallsSuperclass) {
        return [super sampleInstanceMethod:input];
    }
    else {
        return WellKnownMethodReturnValuesOverriddenAtLevel2;
    }
}

@end


//  Hybrid subclasses

@implementation ObjectiveCOverriderOfInheritor

BOOL ObjectiveCOverriderOfInheritorCallsSuperclass = NO;

+ (NSInteger)sampleClassMethod:(NSString *)input {
    if (ObjectiveCOverriderOfInheritorCallsSuperclass) {
        return [super sampleClassMethod:input];
    }
    else {
        return WellKnownMethodReturnValuesOverriddenAtLevel2;
    }
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    if (ObjectiveCOverriderOfInheritorCallsSuperclass) {
        return [super sampleInstanceMethod:input];
    }
    else {
        return WellKnownMethodReturnValuesOverriddenAtLevel2;
    }
}

@end

@implementation ObjectiveCInheritorOfOverrider
@end
