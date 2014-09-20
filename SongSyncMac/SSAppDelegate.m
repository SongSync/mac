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
    BOOL result = [[SSFileManager singleton] fileSystemExists];
    NSLog((result) ? @"exists" : @"does not exists");
}

@end
