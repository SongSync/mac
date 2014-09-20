//
//  SSFIleManager.m
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import "SSFileManager.h"

@implementation SSFileManager

#pragma mark Instance Methods

- (BOOL) fileSystemExists {
    return [[NSFileManager defaultManager] fileExistsAtPath:[SSFileManager pathToFileSystem]];
}

- (void) createFileSystem {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager createDirectoryAtPath:[SSFileManager pathToFileSystem] withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void) parseFileSystem {
    NSLog(@"test");
}

#pragma mark Class Methods

+ (NSString*) pathToFileSystem {
    return [[NSString alloc] initWithFormat:@"%@/SongSync", NSHomeDirectory()];
}

#pragma mark Singleton Methods

+ (id) singleton {
    static SSFileManager *sharedManager = nil;
    @synchronized(self) {
        if (sharedManager == nil)
            sharedManager = [[self alloc] init];
    }
    return sharedManager;
}

@end
