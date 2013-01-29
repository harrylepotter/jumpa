//
//  JumpaAnimation.h
//  Untitled
//
//  Created by Harry Potter on 11/07/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#pragma mark Custom sprite
@interface JumpaSprite : AtlasSprite
{
	NSValue *displayFrameBounds;
}
@property (nonatomic, retain) NSValue *displayFrameBounds;
@end


#pragma mark Animation object
@interface JumpaAnimation : AtlasAnimation {
	NSMutableArray *frameBoundaries;
}
-(void) addFrameWithRect:(CGRect)rect bounds:(CGRect)bounds;
@property (nonatomic, retain) NSMutableArray *frameBoundaries;


@end

#pragma mark Animation action
@class JumpaAnimation;
@class Texture2D;
/** Animates a sprite given the name of an Animation */
@interface JumpaAnimate : IntervalAction <NSCopying>
{
	JumpaAnimation *animation;
	id origFrame;
	BOOL restoreOriginalFrame;
}
/** creates the action with an Animation and will restore the original frame when the animation is over */
+(id) actionWithAnimation:(JumpaAnimation*) a;
/** initializes the action with an Animation and will restore the original frame when the animtion is over */
-(id) initWithAnimation:(JumpaAnimation*) a;
/** creates the action with an Animation */
+(id) actionWithAnimation:(JumpaAnimation*) a restoreOriginalFrame:(BOOL)b;
/** initializes the action with an Animation */
-(id) initWithAnimation:(JumpaAnimation*) a restoreOriginalFrame:(BOOL)b;
@end