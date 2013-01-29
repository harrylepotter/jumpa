//
//  oxyMeterLayer.m
//  jumpa
//
//  Created by harry on 5/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "oxyMeterLayer.h"
#import "MaskTo.h"
#import "SFXManager.h"

#define OXY_METER_BLUE_FADETIME 30.0f
#define OXY_METER_RED_FADETIME 10.0f

@implementation oxyMeterLayer

static oxyMeterLayer *sharedOxyMeter = nil;


+ (oxyMeterLayer *)sharedOxyMeter {
	@synchronized(self)	{
		if (!sharedOxyMeter){
			sharedOxyMeter = [[oxyMeterLayer alloc] init];            
        }
		return sharedOxyMeter;
	}
	// to avoid compiler warning
	return nil;
}


-(id) init
{
	if( ![super init] )
		return nil;
	
	soundNode = [[Sprite node] retain];
	[self addChild:soundNode];
	[[SFXManager sharedSoundManager] addSound:@"oxymeter-redloop" gain:[NSNumber numberWithFloat:0.2f] looped:YES];
	[[SFXManager sharedSoundManager] addSound:@"oxymeter-hitred" gain:[NSNumber numberWithFloat:1.0f] looped:NO];
	[[SFXManager sharedSoundManager] addSound:@"oxymeter-refill" gain:[NSNumber numberWithFloat:1.0f] looped:NO];
	
	layer1_mgr = [[AtlasSpriteManager spriteManagerWithFile:@"OxyMeter_layer1.png" capacity:1] retain];
	layer1 = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 32, 96) spriteManager: layer1_mgr] retain];
	[layer1_mgr addChild:layer1];
	layer1.transformAnchor = ccp(0,0);
	layer1.position = ccp(0,0);
	[self addChild:layer1_mgr];
	
	layer2_mgr = [[AtlasSpriteManager spriteManagerWithFile:@"OxyMeter_layer2.png" capacity:1] retain];
	layer2 = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 32, 96) spriteManager: layer2_mgr] retain];
	[layer2_mgr addChild:layer2];
	layer2.transformAnchor = ccp(0,0);
	layer2.position = ccp(0,0);
	[self addChild:layer2_mgr];
	
	layer3_mgr = [[AtlasSpriteManager spriteManagerWithFile:@"OxyMeter_layer3.png" capacity:1] retain];
	layer3 = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 32, 96) spriteManager: layer3_mgr] retain];
	[layer3_mgr addChild:layer3];
	layer3.transformAnchor = ccp(0,0);
		layer3.position = ccp(0,0);
	[self addChild:layer3_mgr];

	layer4_mgr = [[AtlasSpriteManager spriteManagerWithFile:@"OxyMeter_layer4.png" capacity:1] retain];
		layer4 = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 32, 96) spriteManager: layer4_mgr] retain];
		[layer4_mgr addChild:layer4];
	layer4.transformAnchor = ccp(0,0);
		layer4.position = ccp(0,0);
	[self addChild:layer4_mgr];

	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(refreshFromPickup:)
												 name:@"oxyUpdate" object:nil];
	

//	RCMusicItem *music = [[[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"] retain];
//	sound_refresh_action = [[MusicFadeAction actionWithDuration:2.5f fadeTo:8000.0f property:@"CutoffFrequency" musicItem:music] retain];
//	sound_cutoff_action =  [[MusicFadeAction actionWithDuration:5.0f fadeTo:1.0f property:@"CutoffFrequency" musicItem:music] retain];
//	
	
	[self initOxyActions];
	[self initRedFlashingActions];
	[self initRefreshActions];
	
	[self startOxy];
	
	return self;
	
}

-(void)startOxy{
	[layer3 stopAllActions];
	[layer2 stopAllActions];
	
	[layer3 runAction:startOxy_seq];
	
}

-(void)startFlashingRed
{
	[layer3 stopAllActions];
	[layer2 stopAllActions];
	
	[layer3 setVisible:NO];

	[[SFXManager sharedSoundManager] playSound:@"oxymeter-hitred" atPosition:CGPointZero];	
	[[SFXManager sharedSoundManager] playSound:@"oxymeter-redloop" atPosition:CGPointZero];	
	[layer2 runAction:redOxy_blink];
	[layer2 runAction:redOxy_seq];
	
	if(music == nil){
		music = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"];
		sound_cutoff_action =  [[MusicFadeAction actionWithDuration:5.0f fadeTo:1.0f property:@"CutoffFrequency" musicItem:music] retain];
	}
	if([[[UIApplication sharedApplication] delegate] hasFastCPU]){
		[soundNode stopAllActions];
		[soundNode runAction:sound_cutoff_action];
	}
}

-(void)suffocate{
[[NSNotificationCenter defaultCenter] postNotificationName:@"suffocate" object:self];
}
-(void)refresh{
	NSLog(@"oxylayer: refresh");
	[layer3 stopAllActions];
	[layer2 stopAllActions];
	[[SFXManager sharedSoundManager] stopSound:@"oxymeter-redloop"];		
	[[SFXManager sharedSoundManager] playSound:@"oxymeter-refill" atPosition:CGPointZero];	
	

	[soundNode stopAllActions];
	if(sound_refresh_action == nil){
		RCMusicItem *music = [[RCMusicManager sharedMusicManager] getMusicItemWithName:@"level1"];
		sound_refresh_action = [[MusicFadeAction actionWithDuration:2.5f fadeTo:8000.0f property:@"CutoffFrequency" musicItem:music] retain];
	}
	if([[[UIApplication sharedApplication] delegate] hasFastCPU]){
		[soundNode runAction:sound_refresh_action];
	}

	// refresh blue 

	[layer3 runAction:blueOxy_refresh_seq];
	[layer3 setVisible:YES];
	
	// restore red
	[layer2 runAction:redOxy_refresh_seq];
	
}


-(void)refreshFromPickup:(NSNotification *)notification
{
	[self refresh];
}

-(void)initOxyActions{
	id jumpOut1 = [MoveBy actionWithDuration:0.0 position:ccp(0,0)];
	id mask1 = [MaskTo actionWithDuration:0.0 rect:CGRectMake(0, 4, 32, 96-4)];
	id blue_move_out1 = [Spawn actions:jumpOut1, mask1,  nil];	
	
	id jumpOut = [MoveBy actionWithDuration:OXY_METER_BLUE_FADETIME position:ccp(0,0)];
	id mask = [MaskTo actionWithDuration:OXY_METER_BLUE_FADETIME rect:CGRectMake(0, 57, 32, 96-57)];
	
	id blue_move_out = [Spawn actions:jumpOut, mask, nil];
	id redflash = [CallFunc actionWithTarget:self selector:@selector(startFlashingRed)];
	startOxy_seq= [[Sequence actions:blue_move_out1, blue_move_out, redflash,nil] retain];

}

-(void)initRedFlashingActions{
	id blinking = [Blink actionWithDuration:1.0 blinks:2];
	
	redOxy_blink = [[RepeatForever actionWithAction:blinking] retain];
	
	id jumpOut1 = [MoveBy actionWithDuration:0.0 position:ccp(0,0)];
	id mask1 = [MaskTo actionWithDuration:0.0 rect:CGRectMake(0, 57, 32, 96-57)];
	id blue_move_out1 = [Spawn actions:jumpOut1, mask1,  nil];
	
	id jumpOut2 = [MoveBy actionWithDuration:OXY_METER_RED_FADETIME position:ccp(0,0)];
	id mask2 = [MaskTo actionWithDuration:OXY_METER_RED_FADETIME rect:CGRectMake(0, 76, 32, 96-76)];
	id blue_move_out2 = [Spawn actions:jumpOut2, mask2,  nil];
	
	
	id suffocate = [CallFunc actionWithTarget:self selector:@selector(suffocate)];
	redOxy_seq = [[Sequence actions:blue_move_out1, blue_move_out2, suffocate, nil] retain];
	
}
-(void)initRefreshActions{
	id jumpOut1 = [MoveBy actionWithDuration:0.5 position:ccp(0,0)];
	id mask1 = [MaskTo actionWithDuration:0.5 rect:CGRectMake(0, 0, 32, 96)];
	id blue_move_out1 = [Spawn actions:jumpOut1, mask1,  nil];
	id startagain = [CallFunc actionWithTarget:self selector:@selector(startOxy)];
	blueOxy_refresh_seq = [[Sequence actions:blue_move_out1, startagain,nil] retain];
	
	id jumpOut2 = [MoveBy actionWithDuration:0.0 position:ccp(0,0)];
	id mask2 = [MaskTo actionWithDuration:0.0 rect:CGRectMake(0, 0, 32, 96)];
	redOxy_refresh_seq = [[Spawn actions:jumpOut2, mask2,  nil] retain];
	
	
}


@end
