//
//  boundedSprite.m
//  Untitled
//
//  Created by harry on 2/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "boundedSprite.h"


@implementation boundedSprite
@synthesize charbounds;
@synthesize initialpos;
@synthesize spriteType;

+(boundedSprite*) makeWithFile:(NSString*)file bounds:(CGRect)bounds {	
	self = [super spriteWithFile:file];
	[self setTransformAnchor:ccp(0.0f,0.0f)];
	[self setPosition:ccp(bounds.origin.x, bounds.origin.y)];
	charbounds = bounds;
	initialpos = ccp(bounds.origin.x, bounds.origin.y);
	filename = [file retain];
	spriteType = SPRITE_TYPE_NORMAL;
	return self;
}

+(boundedSprite*) makeWithTexture:(Texture2D*)thetexture bounds:(CGRect)bounds {	
	self = [super spriteWithTexture:thetexture];
	[self setTransformAnchor:ccp(0.0f,0.0f)];
	[self setPosition:ccp(bounds.origin.x, bounds.origin.y)];
	charbounds = bounds;
	initialpos = ccp(bounds.origin.x, bounds.origin.y);
	return self;
}




-(void)setBounds:(CGRect)bounds {
	[self setPosition:ccp(bounds.origin.x, bounds.origin.y)];
	charbounds = bounds;
	initialpos = ccp(bounds.origin.x, bounds.origin.y);
}

-(void)setPosition:(CGPoint)position{
	[super setPosition:position];
	CGPoint pos = [self convertToWorldSpace:CGPointZero];
	charbounds = CGRectMake(initialpos.x + pos.x, initialpos.y + pos.y, charbounds.size.width, charbounds.size.height); 
}




-(void)updateBounds{
	
	//CGPoint pos = [self convertToWorldSpace:CGPointZero];
	//charbounds = CGRectMake(initialpos.x + pos.x, initialpos.y, charbounds.size.width, charbounds.size.height); 
	
	
	CGPoint abspos = [self absolutePosition];
	charbounds.origin.x = abspos.x + initialpos.x;
	charbounds.origin.y = abspos.y + initialpos.y;
}



-(NSValue*)getCharBounds{
	NSLog(@"getcharbounds");
	NSValue *returner = [NSValue valueWithCGRect:charbounds];
	return returner;
}



@end
