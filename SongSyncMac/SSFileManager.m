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
    NSArray *songs = [self loadFilesFromFileSystem];
    NSString *checksum = [self calculateChecksum:songs];
}

- (NSArray*) loadFilesFromFileSystem {
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
            } else {
                NSData *data = [NSData dataWithContentsOfURL:url];
                NSLog(@"%@", data);
            }
            
        }
    }
    
    return songs;
}

- (NSString *) md5ChecksumFromData:(NSData *)data
{
    void *cData = malloc([data length]);
    unsigned char resultCString[16];
    [data getBytes:cData length:[data length]];
    
    CC_MD5(cData, [data length], resultCString);
    free(cData);
    
    NSString *result = [NSString stringWithFormat:
                        @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                        resultCString[0], resultCString[1], resultCString[2], resultCString[3],
                        resultCString[4], resultCString[5], resultCString[6], resultCString[7],
                        resultCString[8], resultCString[9], resultCString[10], resultCString[11],
                        resultCString[12], resultCString[13], resultCString[14], resultCString[15]
                        ];
    return result;
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
