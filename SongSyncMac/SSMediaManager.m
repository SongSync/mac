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
    SSSong *song = [[SSSong alloc] init];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:path options:nil];
    for(NSString *format in [asset availableMetadataFormats]) {
        for(AVMetadataItem *item in [asset metadataForFormat:format]) {
            if([[item commonKey] isEqualToString:@"title"]) {
                song.title = (NSString *)[item value];
            } else if([[item commonKey] isEqualToString:@"artist"]) {
                song.artist = (NSString *)[item value];
            } else if([[item commonKey] isEqualToString:@"albumName"]) {
                song.albumTitle = (NSString *)[item value];
            } else if([[item commonKey] isEqualToString:@"copyrights"]) {
                song.copyrights = (NSString *)[item value];
            } else if([[item commonKey] isEqualToString:@"title"]) {
                song.type = (NSString *)[item value];
            }
        }
    }
    return song;
}

@end
