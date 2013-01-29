//
//  EnemyLayer.h
//  Untitled
//
//  Created by Harry Potter on 26/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BigMushroomEnemy.h"
#import "SFXManager.h"
#import "PASoundMgr.h"

@interface EnemyLayer: Layer
{
    TextureAtlas *atlas;
	CocosNode *voidNode;
	
	BigMushroomEnemy *bme;
	
	NSMutableArray *bounds;
	
	NSArray *allEnemyData;
	NSMutableArray *curEnemyData;
	int dataIndex;
	float curMaxXPosition;
	
	
}

-(NSMutableArray*)getBounds;

@end
