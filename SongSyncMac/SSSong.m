//
//  SSSong.m
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import "SSSong.h"

@implementation SSSong
- (void) inspect {
    NSLog(@"Title: %@\nArtist: %@\nAlbum Title: %@\nCopyrights: %@, Type: %@", [self title], [self artist], [self albumTitle], [self copyrights], [self type]);
}
@end
