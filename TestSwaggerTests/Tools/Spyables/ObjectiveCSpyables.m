//
//  ObjectiveCSpyables.m
//  TestSwagger
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

#import "ObjectiveCSpyables.h"


NSInteger const NormalMethodReturnValueAtRoot = 14;
NSInteger const NormalMethodReturnValueOverridenAtLevel1 = 42;
NSInteger const NormalMethodReturnValueOverridenAtLevel2 = 99;

NSInteger const SpyMethodReturnValue = -18;


//  Root sample class

@implementation ObjectiveCRootSpyable

static BOOL objectiveCRootSpyableCallSuperclass = NO;

+ (BOOL)callsSuperclass {
    return objectiveCRootSpyableCallSuperclass;
}

+ (void)setCallsSuperclass:(BOOL)callsSuperclass {
    objectiveCRootSpyableCallSuperclass = callsSuperclass;
}

+ (NSInteger)sampleClassMethod:(NSString *)input {
    return NormalMethodReturnValueAtRoot;
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    return NormalMethodReturnValueAtRoot;
}

@end


// Overriding subclasses

@implementation ObjectiveCOverrider

static BOOL objectiveCOverriderCallSuperclass = NO;

+ (BOOL)callsSuperclass {
    return objectiveCOverriderCallSuperclass;
}

+ (void)setCallsSuperclass:(BOOL)callsSuperclass {
    objectiveCOverriderCallSuperclass = callsSuperclass;
}

+ (NSInteger)sampleClassMethod:(NSString *)input {
    if (self.callsSuperclass) {
        return [super sampleClassMethod:input];
    }
    else {
        return NormalMethodReturnValueOverridenAtLevel1;
    }
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    if ([[self class] callsSuperclass]) {
        return [super sampleInstanceMethod:input];
    }
    else {
        return NormalMethodReturnValueOverridenAtLevel1;
    }
}

@end

@implementation ObjectiveCOverriderOfOverrider

static BOOL objectiveCOverriderOfOverriderCallSuperclass = NO;

+ (BOOL)callsSuperclass {
    return objectiveCOverriderOfOverriderCallSuperclass;
}

+ (void)setCallsSuperclass:(BOOL)callsSuperclass {
    objectiveCOverriderOfOverriderCallSuperclass = callsSuperclass;
}

+ (NSInteger)sampleClassMethod:(NSString *)input {
    if (self.callsSuperclass) {
        return [super sampleClassMethod:input];
    }
    else {
        return NormalMethodReturnValueOverridenAtLevel2;
    }
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    if ([[self class] callsSuperclass]) {
        return [super sampleInstanceMethod:input];
    }
    else {
        return NormalMethodReturnValueOverridenAtLevel2;
    }
}

@end


// Inheriting subclasses

@implementation ObjectiveCInheritor
@end

@implementation ObjectiveCInheritorOfInheritor
@end


//  Hybrid subclasses

@implementation ObjectiveCOverriderOfInheritor

static BOOL objectiveCOverriderOfInheritorCallSuperclass = NO;

+ (BOOL)callsSuperclass {
    return objectiveCOverriderOfInheritorCallSuperclass;
}

+ (void)setCallsSuperclass:(BOOL)callsSuperclass {
    objectiveCOverriderOfInheritorCallSuperclass = callsSuperclass;
}

+ (NSInteger)sampleClassMethod:(NSString *)input {
    if (self.callsSuperclass) {
        return [super sampleClassMethod:input];
    }
    else {
        return NormalMethodReturnValueOverridenAtLevel2;
    }
}

- (NSInteger)sampleInstanceMethod:(NSString *)input {
    if ([[self class] callsSuperclass]) {
        return [super sampleInstanceMethod:input];
    }
    else {
        return NormalMethodReturnValueOverridenAtLevel2;
    }
}

@end

@implementation ObjectiveCInheritorOfOverrider
@end
