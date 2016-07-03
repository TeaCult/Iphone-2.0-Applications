//
//  ASingletonClass.h
//  LotoTest
//
//  Created by Gediz GÜRSU on 3/7/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASingletonClass : NSObject {
	NSMutableString *aStorageString;
	
	

}
@property (nonatomic,retain) NSMutableString * aStorageString;

+ (ASingletonClass*)sharedManager;
+ (id)allocWithZone:(NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;
- (id)retain;
- (unsigned)retainCount;
- (void)release;
- (id)autorelease;

@end
