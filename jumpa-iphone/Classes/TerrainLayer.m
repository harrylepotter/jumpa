//
//  SceneryLayer.m
//  Untitled
//
//  Created by Harry Potter on 12/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import "TerrainLayer.h"
#import "BigMushroomEnemy.h"
#import "boundedSprite.h"
#import "cocos2d/Support/Texture2D.h"

#define COLLIDER_ARRAY_SIZE 11


@implementation TerrainLayer

-(id) init
{
	if( ![super init] )
		return nil;

	
	return self;
	
}

-(void)draw{

}

-(void)setData:(NSArray*)terrainData
{
	
	for(int i=0; i< [terrainData count]; i++){
		
		NSDictionary *curitem = [terrainData objectAtIndex:i];
		NSNumber *x = [curitem objectForKey:@"x"];
		float xfloat = [x floatValue];
		NSNumber *y = [curitem objectForKey:@"y"];
		float yfloat = [y floatValue];
		
		float spriteheight = [[curitem objectForKey:@"height"] floatValue];
		float spritewidth = [[curitem objectForKey:@"width"] floatValue];
		NSString *filename = [[curitem objectForKey:@"filename"] retain];
	
		boundedSprite *currterrain;
		currterrain = [boundedSprite makeWithFile:filename bounds:CGRectMake(0.0f, 0.0f, spritewidth+10, spriteheight)];
		currterrain.position =  ccp(xfloat, yfloat);
		if([filename hasPrefix:@"ShroomDoomGround"]){
			[currterrain setSpriteType:SPRITE_TYPE_GROUND];
		}else{
			[currterrain setSpriteType:SPRITE_TYPE_NORMAL];
		}
		[self addChild:currterrain z:1];
	}
	
	
}


-(int)setXPosition:(NSNumber*)xpos{
}

-(void)setPosition:(CGPoint)position{
	[super setPosition:position];
	
	NSArray *children = [self children];
	for(int i=0;i<[children count];i++){
		boundedSprite *current = [children objectAtIndex:i];
		[current updateBounds];
		
	}
	
	
}

- (void) setOpacity: (GLubyte)newOpacity
{

	NSArray *children = [self children];
	for(int i=0;i<[children count];i++){
		[[children objectAtIndex:i] setOpacity:newOpacity];
	}
	
}


-(NSMutableArray*)getBounds
{
	return bounds;
	
}

-(NSString *) title
{
	return @"";
}

@end
