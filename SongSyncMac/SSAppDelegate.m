//
//  SSAppDelegate.m
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import "SSAppDelegate.h"

@implementation SSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"Starting SongSync...");
    [self start];
    NSLog(@"SongSync has started...");
}

- (void) start {
    // Just the singleton file system manager
    SSFileManager *manager = [SSFileManager singleton];
    
    // Does the internal file system exist?
    BOOL result = [manager fileSystemExists];
    
    // if not, lets create it
    if(!result) {
        NSLog(@"File system does not exist. Creating now...");
        [manager createFileSystem];
    }
    
    //[NSTimer scheduledTimerWithTimeInterval:5.0 target:manager selector:@selector(parseFileSystem) userInfo:nil repeats:YES];

    [manager parseFileSystem];
}
@end
