//
//  MaskTo.m
//  Untitled
//
//  Created by harry on 14/09/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MaskTo.h"

@implementation MaskTo
+(id) actionWithDuration: (ccTime) t rect: (CGRect) r{
	return [[[self alloc] initWithDuration:t rect:r ] autorelease];
}

-(id) initWithDuration: (ccTime) t rect: (CGRect) r{
	if( !(self=[super initWithDuration: t]) )
		return nil;
	
	endRect = r;
	return self;
}

-(id) copyWithZone: (NSZone*) zone{
	Action *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration] rect: endRect];
	return copy;
}

-(void) start{
	[super start];
	startRect = [(AtlasSprite*)target textureRect];
	CGPoint endXY = ccp(endRect.origin.x, endRect.origin.y);
	CGPoint endWH = ccp(endRect.size.width, endRect.size.height);
	
	CGPoint startXY = ccp(startRect.origin.x, startRect.origin.y);
	CGPoint startWH = ccp(startRect.size.width, startRect.size.height);
	
	CGPoint deltaXY = ccpSub( endXY, startXY );
	CGPoint deltaWH = ccpSub( endWH, startWH );
	delta = CGRectMake(deltaXY.x, deltaXY.y, deltaWH.x, deltaWH.y);
}

-(void) update: (ccTime) t{
	CGRect newTextureRect = CGRectMake(
									   (startRect.origin.x + delta.origin.x * t ), (startRect.origin.y + delta.origin.y * t ),
									   (startRect.size.width + delta.size.width * t ), (startRect.size.height + delta.size.height * t ) );
	[(AtlasSprite*)target setTextureRect: newTextureRect];
}

@end