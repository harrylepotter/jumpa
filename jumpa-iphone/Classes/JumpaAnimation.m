//
//  JumpaAnimation.m
//  Untitled
//
//  Created by Harry Potter on 11/07/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import "JumpaAnimation.h"

#pragma mark custom sprite
@implementation JumpaSprite
@synthesize displayFrameBounds;
@end


@implementation JumpaAnimation

@synthesize frameBoundaries;

+(id) animationWithName:(NSString*)aname delay:(float)d
{
	return [[[self alloc] initWithName:aname delay:d] autorelease];
}

-(id) initWithName:(NSString*)t delay:(float)d
{
	return [self initWithName:t delay:d firstFrame:nil vaList:nil];
}

/* initializes an AtlasAnimation with an AtlasSpriteManager, a name, and the frames from AtlasSpriteFrames */
-(id) initWithName:(NSString*)t delay:(float)d firstFrame:(AtlasSpriteFrame*)frame vaList:(va_list)args
{
	if( (self=[super init]) ) {
		name = t;
		frames = [[NSMutableArray array] retain];
		self.frameBoundaries = [[NSMutableArray array] retain];
		delay = d;
		
		if( frame ) {
			[frames addObject:frame];
			
			AtlasSpriteFrame *frame2 = va_arg(args, AtlasSpriteFrame*);
			while(frame2) {
				[frames addObject:frame2];
				frame2 = va_arg(args, AtlasSpriteFrame*);
			}	
		}
	}
	return self;
}

-(void) addFrameWithRect:(CGRect)rect bounds:(CGRect)bounds{
	////NSLog(@"adding frame boundaries");
	[super addFrameWithRect:rect];
	NSValue *newbounds = [NSValue valueWithCGRect:bounds];
	[self.frameBoundaries addObject:newbounds];
	//[newbounds release];
}



@end


#pragma mark Animate
//
// Animate
//
@implementation JumpaAnimate

+(id) actionWithAnimation: (JumpaAnimation*)anim
{
	return [[[self alloc] initWithAnimation:anim restoreOriginalFrame:YES] autorelease];
}

+(id) actionWithAnimation: (JumpaAnimation*)anim restoreOriginalFrame:(BOOL)b
{
	return [[[self alloc] initWithAnimation:anim restoreOriginalFrame:b] autorelease];
}

-(id) initWithAnimation: (JumpaAnimation*)anim
{
	NSAssert( anim!=nil, @"Animate: argument Animation must be non-nil");
	return [self initWithAnimation:anim restoreOriginalFrame:YES];
}

-(id) initWithAnimation: (JumpaAnimation*)anim restoreOriginalFrame:(BOOL) b
{
	NSAssert( anim!=nil, @"Animate: argument Animation must be non-nil");
	
	if( (self=[super initWithDuration: [[anim frames] count] * [anim delay]]) ) {
		
		restoreOriginalFrame = b;
		animation = [(JumpaAnimation*)anim retain];
		//origFrame = [[anim frames] objectAtIndex:1];
		
	}
	
	// start the sprite on the first frame 
	//id<CocosNodeFrames> sprite = (id<CocosNodeFrames>) target;
	//[sprite setDisplayFrame: [[animation frames] objectAtIndex:-1]];
	
		
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	return [[[self class] allocWithZone: zone] initWithAnimation: animation];
}

-(void) dealloc
{
	[animation release];
	[origFrame release];
	[super dealloc];
}

-(void) start
{
	[super start];
	id<CocosNodeFrames> sprite = (id<CocosNodeFrames>) target;
	
	
	
	[origFrame release];
	
	origFrame = [[sprite displayFrame] retain];
}

-(void) stop
{
	//if( restoreOriginalFrame ) {
	//	id<CocosNodeFrames> sprite = (id<CocosNodeFrames>) target;
	//	[sprite setDisplayFrame:origFrame];
		
	//}
	
	
	// ben
	id<CocosNodeFrames> sprite = (id<CocosNodeFrames>) target;
	[sprite setDisplayFrame: [[animation frames] objectAtIndex:0]];
	NSValue *curframebounds = [animation.frameBoundaries objectAtIndex:0];
	[sprite setDisplayFrameBounds:curframebounds];
//	
	
	
	[super stop];
}

-(void)reset{
	id<CocosNodeFrames> sprite = (id<CocosNodeFrames>) target;
	[sprite setDisplayFrame: [[animation frames] objectAtIndex:0]];
	NSValue *curframebounds = [animation.frameBoundaries objectAtIndex:0];
	[sprite setDisplayFrameBounds:curframebounds];
		
}

-(void) update: (ccTime) t
{
	NSUInteger idx=0;
	
	ccTime slice = 1.0f / [[animation frames] count];
	
	
	
	if(t !=0 ){
		idx = t/ slice;
	}
	
	if( idx >= [[animation frames] count] ) {
		idx = [[animation frames] count] -1;
	}

	id<CocosNodeFrames> sprite = (id<CocosNodeFrames>) target;

	if (! [sprite isFrameDisplayed: [[animation frames] objectAtIndex: idx]] ) {
		[sprite setDisplayFrame: [[animation frames] objectAtIndex:idx]];
		
		NSValue *curframebounds = [animation.frameBoundaries objectAtIndex:idx];
		[sprite setDisplayFrameBounds:curframebounds];

	}
}
@end
