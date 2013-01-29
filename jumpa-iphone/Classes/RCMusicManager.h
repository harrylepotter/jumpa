//
//  RCMusicManager.h
//  Untitled
//
//  Created by harry on 18/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCMusicItem.h"

@interface RCMusicManager : NSObject {
	NSMutableDictionary *musicItems;
}

-(void)addMusicItem:(RCMusicItem*)item;
-(RCMusicItem*)addMusicItemWithName:(NSString*)name;
-(RCMusicItem*)getMusicItemWithName:(NSString*)name;
-(void)removeMusicItemWithName:(NSString*)name;


@end
