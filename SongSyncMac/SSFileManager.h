//
//  SSFIleManager.h
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSMediaManager.h"

@interface SSFileManager : NSObject

- (BOOL) fileSystemExists;
- (void) createFileSystem;
- (void) parseFileSystem;

+ (NSString*) pathToFileSystem;

+ (id) singleton;

@end
