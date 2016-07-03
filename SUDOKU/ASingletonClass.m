//
//  ASingletonClass.m
//  LotoTest
//
//  Created by Gediz GÜRSU on 3/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ASingletonClass.h"


@implementation ASingletonClass

@synthesize aStorageString;

static ASingletonClass *sharedSingletonManager = nil;

+ (ASingletonClass*)sharedManager
{
    @synchronized(self) {
        if (sharedSingletonManager == nil) {
            [[self alloc] init]; // assignment not done here
        }
    }
    return sharedSingletonManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) {
        if (sharedSingletonManager == nil) {
            sharedSingletonManager = [super allocWithZone:zone];
            return sharedSingletonManager;  // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (unsigned)retainCount
{
    return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end