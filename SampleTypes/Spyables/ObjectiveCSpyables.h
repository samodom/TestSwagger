//
//  ObjectiveCSpyables.h
//  SampleTypes
//
//  Created by Sam Odom on 12/17/16.
//  Copyright © 2016 Swagger Soft. All rights reserved.
//

@import Foundation;


//  Root sample class

@interface ObjectiveCRootSpyable : NSObject

+ (NSInteger)sampleClassMethod:(NSString *)input;
- (NSInteger)sampleInstanceMethod:(NSString *)input;

@end


// Inheriting subclasses

@interface ObjectiveCInheritor: ObjectiveCRootSpyable
@end

@interface ObjectiveCInheritorOfInheritor: ObjectiveCInheritor
@end


// Overriding subclasses

FOUNDATION_EXPORT BOOL ObjectiveCOverriderCallsSuperclass;

@interface ObjectiveCOverrider: ObjectiveCRootSpyable
@end

FOUNDATION_EXPORT BOOL ObjectiveCOverriderOfOverriderCallsSuperclass;

@interface ObjectiveCOverriderOfOverrider: ObjectiveCOverrider
@end


//  Hybrid subclasses

FOUNDATION_EXPORT BOOL ObjectiveCOverriderOfInheritorCallsSuperclass;

@interface ObjectiveCOverriderOfInheritor: ObjectiveCInheritor
@end

@interface ObjectiveCInheritorOfOverrider: ObjectiveCOverrider
@end
