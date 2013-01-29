//
//  SceneryLayer.m
//  Untitled
//
//  Created by Harry Potter on 12/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import "EnemyLayer.h"
#import "BigMushroomEnemy.h"
#import "MediumMushroomEnemy.h"
#import "SmallMushroomEnemy.h"
#import "WingedMushroomEnemy.h"

#define COLLIDER_ARRAY_SIZE 10


@implementation EnemyLayer

-(id) init
{
	if( ![super init] )
		return nil;
	return self;
	
}


-(void)setData:(NSArray*)enemyData
{
	
	
	//dataIndex =0;
//	curMaxXPosition = 0.0f;
//	curEnemyData = [[NSMutableArray alloc] initWithCapacity:COLLIDER_ARRAY_SIZE];

//	NSSortDescriptor* nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"x" ascending:YES selector:@selector(compare:)];
//	allEnemyData = [[enemyData sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]] retain];
	
	
		
	
	for(int i=0; i<[enemyData count]; i++){
		NSDictionary *curitem = [enemyData objectAtIndex:i];
		NSNumber *x = [curitem objectForKey:@"x"];
		float xfloat = [x floatValue];
		NSNumber *y = [curitem objectForKey:@"y"];
		float yfloat = [y floatValue];
		
		int enemyType = [[curitem objectForKey:@"type"] intValue];
		if(enemyType == 4){
			WingedMushroomEnemy *wingedCunt = [WingedMushroomEnemy make];
			wingedCunt.position = ccp(xfloat, yfloat);
			[self addChild:wingedCunt];
		}else if(enemyType == 3){
			////NSLog(@"BIG at %f,%f", xfloat, yfloat);
			BigMushroomEnemy *bme2 = [BigMushroomEnemy make];
			bme2.position = ccp(xfloat, yfloat);
			[self addChild:bme2];
		}else if(enemyType == 2){
			MediumMushroomEnemy *bme3 = [MediumMushroomEnemy make];
			bme3.position = ccp(xfloat, yfloat);
			[self addChild:bme3];
		}else if(enemyType == 1){
			SmallMushroomEnemy *bme4 = [SmallMushroomEnemy make];
			bme4.position = ccp(xfloat, yfloat);
			
			[self addChild:bme4];
		}
		
	}
	
	

	
	
	
	
	
	
	
	
	

	
	//dataIndex =0;
//	curMaxXPosition = 0.0f;
//	curEnemyData = [[NSMutableArray alloc] initWithCapacity:COLLIDER_ARRAY_SIZE];
//	
//	[Texture2D setAliasTexParameters];
//
//	NSSortDescriptor* nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"x" ascending:YES selector:@selector(compare:)];
//	allEnemyData = [[enemyData sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]] retain];
//	
//
//	
//	
//	for(int i=0; i<COLLIDER_ARRAY_SIZE; i++){
//		NSDictionary *curitem = [allEnemyData objectAtIndex:i];
//		NSNumber *x = [curitem objectForKey:@"x"];
//		float xfloat = [x floatValue];
//		NSNumber *y = [curitem objectForKey:@"y"];
//		float yfloat = [y floatValue];
//		
//		int enemyType = [[curitem objectForKey:@"type"] intValue];
//		
//		if(enemyType == 3){
//			////NSLog(@"BIG at %f,%f", xfloat, yfloat);
//			BigMushroomEnemy *bme2 = [BigMushroomEnemy make];
//			bme2.position = ccp(xfloat, yfloat);
//			[self addChild:bme2];
//		}else if(enemyType == 2){
//			////NSLog(@"MEDIUM at %f,%f", xfloat, yfloat);
//			MediumMushroomEnemy *bme3 = [MediumMushroomEnemy make];
//			bme3.position = ccp(xfloat, yfloat);
//			[self addChild:bme3];
//		}else if(enemyType == 1){
//			////NSLog(@"SMALL at %f,%f", xfloat, yfloat);
//			SmallMushroomEnemy *bme4 = [SmallMushroomEnemy make];
//			bme4.position = ccp(xfloat, yfloat);
//			
//			[self addChild:bme4];
//		}
//		
//	}
	
	

}

-(void)draw{
	
}

-(void)setXPosition:(NSNumber*)xpos{
	
	//[self removeAll];
	
//	if([xpos floatValue] > curMaxXPosition){
//		
//
//		int oldDataIndex = dataIndex;
//		int maximum = oldDataIndex + COLLIDER_ARRAY_SIZE;
//		if (maximum > [allEnemyData count])
//			maximum = [allEnemyData count];
//		
//		for(int i=oldDataIndex; i<maximum; i++){
//			NSDictionary *curitem = [allEnemyData objectAtIndex:i];
//			NSNumber *x = [curitem objectForKey:@"x"];
//			float xfloat = [x floatValue];
//			NSNumber *y = [curitem objectForKey:@"y"];
//			float yfloat = [y floatValue];
//			
//			int enemyType = [[curitem objectForKey:@"type"] intValue];
//			
//			if(enemyType == 3){
//				////NSLog(@"BIG at %f,%f", xfloat, yfloat);
//				BigMushroomEnemy *bme2 = [BigMushroomEnemy make];
//				bme2.position = ccp(xfloat, yfloat);
//				[self addChild:bme2];
//			}else if(enemyType == 2){
//				////NSLog(@"MEDIUM at %f,%f", xfloat, yfloat);
//				MediumMushroomEnemy *bme3 = [MediumMushroomEnemy make];
//				bme3.position = ccp(xfloat, yfloat);
//				[self addChild:bme3];
//			}else if(enemyType == 1){
//				////NSLog(@"SMALL at %f,%f", xfloat, yfloat);
//				SmallMushroomEnemy *bme4 = [SmallMushroomEnemy make];
//				bme4.position = ccp(xfloat, yfloat);
//				
//				[self addChild:bme4];
//				dataIndex++;
//				curMaxXPosition = xfloat;
//				
//			}
//			
//		}
//	}
	
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
