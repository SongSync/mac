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
    NSMutableArray *songs = [[NSMutableArray alloc] init];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSArray *keys = [NSArray arrayWithObject:NSURLIsDirectoryKey];
    NSURL *url = [NSURL URLWithString:[SSFileManager pathToFileSystem]];
    
    NSDirectoryEnumerator *enumerator = [manager
                                         enumeratorAtURL:url
                                         includingPropertiesForKeys:keys
                                         options:0
                                         errorHandler:^(NSURL *url, NSError *error) {
                                             return YES; // we want to continue
                                         }];
    
    for (NSURL *url in enumerator) {
        NSError *error;
        NSNumber *isDirectory = nil;
        NSNumber *isHidden = nil;
        
        if (![url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error] || ![url getResourceValue:&isHidden forKey:NSURLIsHiddenKey error:&error]) { //Make sure its not hidden, and determining if its a directory
            NSLog(@"Error: %@", error);
        } else if(![isHidden boolValue]) {
            
            if(![isDirectory boolValue]) {
                
                // Gather the filesystem and new song path to get the difference
                NSArray *filesystemPath = [[NSURL URLWithString:[SSFileManager pathToFileSystem]] pathComponents];
                NSArray *songPath = [url pathComponents];
                
                int oldArrayCount = [filesystemPath count];
                
                NSArray *finalPath = [songPath subarrayWithRange:NSMakeRange(oldArrayCount - 1, [songPath count] - (oldArrayCount - 1))]; 
                
                NSString *fileName = [finalPath objectAtIndex:[finalPath count] - 1]; // Final
                NSString *playlistName = (NSString*) [finalPath objectAtIndex:1]; // Final
                
                if([finalPath count] <= 2) {
                    playlistName = @"Default";
                }

                SSSong *song = [SSMediaManager readMetadata:url];
                [song inspect];
                
                [songs addObject:song];
            }
            
        }
    }
    
    // Now we have an NSArray full of songs.
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
