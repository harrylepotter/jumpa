//
//  RCMusicManager.m
//  Untitled
//
//  Created by harry on 18/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCMusicManager.h"


@implementation RCMusicManager


static RCMusicManager *sharedMusicManager = nil;

+ (RCMusicManager *)sharedMusicManager {
	@synchronized(self)	{
		if (!sharedMusicManager){
			sharedMusicManager = [[RCMusicManager alloc] init];            
        }
		return sharedMusicManager;
	}
	// to avoid compiler warning
	return nil;
}

+ (id)alloc {
	@synchronized(self)
	{
		NSAssert(sharedMusicManager  == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedMusicManager = [super alloc];
		return sharedMusicManager;
	}
	// to avoid compiler warning
	return nil;
}

- (id)init {
	self = [super init];
	musicItems = [[NSMutableDictionary dictionaryWithCapacity:10] retain];
	BASS_Init(-1, 44100, 0, 0, 0); // initialize output device
	return self;
}

-(void)addMusicItem:(RCMusicItem*)item{
	[musicItems setObject:item forKey:@"testing"];
}

-(RCMusicItem*)addMusicItemWithName:(NSString*)name{
	RCMusicItem *itemToAdd = [[[RCMusicItem alloc] initWithFile:name] retain];
	[musicItems setObject:itemToAdd forKey:name];
	return itemToAdd;
}

-(RCMusicItem*)getMusicItemWithName:(NSString*)name{
	return [musicItems objectForKey:name];
}
-(void)removeMusicItemWithName:(NSString*)name{
	[musicItems removeObjectForKey:name];
}



@end
