//
//  SSMediaManager.h
//  SongSyncMac
//
//  Created by Andrew Page on 9/20/14.
//  Copyright (c) 2014 SongSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "SSSong.h"

@interface SSMediaManager : NSObject
+ (SSSong*) readMetadata: (NSURL*) path;
@end
