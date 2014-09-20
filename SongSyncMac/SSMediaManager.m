//
//  SSMediaManager.m
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import "SSMediaManager.h"

@implementation SSMediaManager

+ (SSSong*) readMetadata:(NSURL *)path {
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:path options:nil];
    
    for(NSString *format in [asset availableMetadataFormats]) {
        NSLog(@"%@", format);
    }
    
    return nil;
}

@end
