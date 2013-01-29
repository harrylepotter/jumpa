//
//  CheckpointLayer.m
//  jumpa
//
//  Created by harry on 8/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CheckpointLayer.h"


@implementation CheckpointLayer

-(id) init
{
	if( ![super init] )
		return nil;
	
	checkpointgfx = [[Sprite spriteWithFile:@"CheckPoint.png"] retain];
	checkpointgfx.transformAnchor = ccp(0.0f,0.0f);
	checkpointgfx.position = ccp(480.0f,180.0f);
	[self addChild:checkpointgfx];
	
	move = [[MoveBy actionWithDuration:0.5f position:ccp(-480,0)] retain];
	waitabit = [[DelayTime actionWithDuration:1.0f] retain];
	move_ease_inout1 = [[EaseInOut actionWithAction:[[move copy] autorelease] rate:1.0f] retain];
	//move_ease_inout_back = [[move_ease_inout1 reverse] retain];
	move_ease_inout_back= [[MoveBy actionWithDuration:1.0f position:ccp(480,0)] retain];
	//move_ease_inout_fade = [[FadeOut actionWithDuration:3.0f] retain];
	blinking = [[Blink actionWithDuration:2.0f blinks:4] retain];
	move_ease_inout_back1 = [[Spawn actions:move_ease_inout_back, /*move_ease_inout_fade,*/ blinking, nil] retain];
	return_to_original = [[CallFunc actionWithTarget:self selector:@selector(finished)] retain];
	seq1 = [[Sequence actions: move_ease_inout1, waitabit, move_ease_inout_back1, return_to_original, nil] retain];
	
	
		
	return self;
	
}


-(void)setSfxManager:(SFXManager*)sfxman
{
	//NSLog(@"checkpointLayer: setSfxManager");
	sfx = [sfxman retain];
}
-(void)showCheckPoint
{
	//NSLog(@"showCheckPoint");
	[sfx playSound:@"CheckPoint" atPosition:ccp(0.0,0.0)];
	[checkpointgfx runAction: seq1];

}

-(void)finished
{
	[checkpointgfx setOpacity:255];
	[checkpointgfx setVisible:YES];
}



@end
