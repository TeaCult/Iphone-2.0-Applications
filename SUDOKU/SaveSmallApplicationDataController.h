//
//  SaveSmallApplicationDataController.h
//  I-Kelime
//
//  Created by Gediz GÜRSU on 2/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SaveSmallApplicationDataController : NSObject {

}

+(void)savePrefsOfObject:(id)objectToSave forKey:(NSString *)keyName;
+(id)restorePrefsOfObjectForKey:(NSString *)keyName;

@end
