//
//  SaveSmallApplicationDataController.m
//  I-Kelime
//
//  Created by Gediz GÜRSU on 2/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SaveSmallApplicationDataController.h"


@implementation SaveSmallApplicationDataController

+(void)savePrefsOfObject:(id)objectToSave forKey:(NSString *)keyName {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:(id)objectToSave forKey:keyName];
}
+(id)restorePrefsOfObjectForKey:(NSString *)keyName {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	id anObject=[prefs objectForKey:keyName];
	if(anObject==nil)
		NSLog(@"No such object at preferences is found !!!");
	return anObject;
}
	
	
@end
