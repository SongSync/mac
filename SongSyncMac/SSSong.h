//
//  SSSong.h
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSSong : NSObject
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *artist;
@property (nonatomic, retain) NSString *albumTitle;
@property (nonatomic, retain) NSString *copyrights;
@property (nonatomic, retain) NSString *type;

- (void) inspect;
@end
