//
//  SSFIleManager.h
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "SSMediaManager.h"
#import "SSSong.h"

@interface SSFileManager : NSObject

- (BOOL) fileSystemExists;
- (void) createFileSystem;
- (void) parseFileSystem;
- (NSString *)md5StringFromData:(NSData *)data;

+ (NSString*) pathToFileSystem;

+ (id) singleton;

@end
