//
//  MusicFadeAction.m
//  Untitled
//
//  Created by harry on 19/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MusicFadeAction.h"


@implementation MusicFadeAction
+(id) actionWithDuration: (ccTime) t fadeTo:(float)to property:(NSString*)prop musicItem:(id)tgt
{	
	return [[[self alloc] initWithDuration:t fadeTo:to property:prop musicItem:tgt] autorelease];
}

-(id) initWithDuration: (ccTime) t fadeTo:(float)to property:(NSString*)prop musicItem:(id)tgt
{
	if( !(self=[super initWithDuration: t]) )
		return nil;
	
	NSLog(@"init: fade property(%@) to %f", prop, to);
	musictarget = tgt;
	NSString *getterString = [NSString stringWithFormat:@"get%@", prop];
	NSString *setterString = [NSString stringWithFormat:@"set%@:", prop];
	
	getter = NSSelectorFromString(getterString);
	setter = NSSelectorFromString(setterString);
	
	
	fadeto = to;
	
	return self;
}

-(id) copyWithZone: (NSZone*) zone
{
	Action *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration]];
	return copy;
}

-(void) start
{
	[super start];

	id fuck = [musictarget performSelector:getter];
	fadefrom = [fuck floatValue];
}

-(void) update: (ccTime) t
{	
	
		float tee= t*[self duration];
		float output = 0;
		
		if(fadeto >= fadefrom){
			// FADE OUT
			float projectedGain_coeff =(M_PI*tee)/(2.0f*[self duration]);
			output= fadeto + (fadefrom - fadeto)*(1 - sinf(projectedGain_coeff));
		}else{	
			// FADE IN
			output = fadefrom + (fadeto - fadefrom)*sinf((M_PI*tee)/(2.0f*[self duration]));
		}
		
		[musictarget performSelector:setter withObject:[NSNumber numberWithFloat:output]];
	
}

-(IntervalAction*) reverse
{
	return self;
}

@end
