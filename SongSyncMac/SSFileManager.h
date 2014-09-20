//
//  SSFIleManager.h
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSFileManager : NSObject

- (BOOL) fileSystemExists;
- (void) createFileSystem;

+ (NSString*) pathToFileSystem;

+ (id) singleton;

@end