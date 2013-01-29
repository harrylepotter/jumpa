//
//  boundedSprite.m
//  Untitled
//
//  Created by harry on 2/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "animatedBoundedSprite.h"


@implementation animatedBoundedSprite
@synthesize charbounds;
@synthesize initialpos;


+(animatedBoundedSprite*) makeWithFile:(NSString*)file frameSize:(CGRect)p_framesize delay:(NSNumber*)delayTime{	
	self = [super node];
	
	[self setTransformAnchor:ccp(0.0f,0.0f)];
	//[self setPosition:ccp(pos.x, pos.y)];
	mgr = [[AtlasSpriteManager spriteManagerWithFile:file] retain];
	[self addChild:mgr];
	coreSprite = [[JumpaSprite spriteWithRect:p_framesize spriteManager:mgr] retain];
	coreSprite.transformAnchor = ccp(0,0);
	animation = [[JumpaAnimation animationWithName:file delay:[delayTime floatValue]] retain];
	[mgr addChild:coreSprite];
	return self;
}

-(void)addFrame: (CGRect)rect bounds:(CGRect)bounds{
	[animation addFrameWithRect:(CGRect)rect bounds:bounds];
	charbounds = bounds;
}

-(void)finaliseAnimation{
	animation_action = [[JumpaAnimate actionWithAnimation:animation] retain];
}
						
-(void)playAnimation:(BOOL)looped{
	if(!animation_action)
		[self finaliseAnimation];
	
	if(looped){
		[coreSprite runAction:[RepeatForever actionWithAction:animation_action]];
	}else{
		[coreSprite runAction:animation_action];
	}
}

-(void)stopAnimation{
	[coreSprite stopAllActions];
}


-(void)draw{
	[super draw];
	[self updateBounds];
}


-(void)setPosition:(CGPoint)position{
	
	[coreSprite setPosition:position];
	[self updateBounds]; 
}

-(CGPoint)position{
	//NSLog(@"getPosition ");
	return [coreSprite position];
}

-(void)updateBounds{	
	NSValue *bounds = [coreSprite displayFrameBounds];
	CGPoint abspos = [coreSprite convertToWorldSpace:CGPointZero];
	if(bounds != nil){
		charbounds = [bounds CGRectValue];
		charbounds.origin.x = abspos.x + charbounds.origin.x;
		charbounds.origin.y = abspos.y + charbounds.origin.y;
	}

}

- (void) setOpacity: (GLubyte)newOpacity
{
	[coreSprite setOpacity:newOpacity];
}


@end
