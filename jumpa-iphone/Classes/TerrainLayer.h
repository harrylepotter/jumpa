//
//  SceneryLayer.h
//  Untitled
//
//  Created by Harry Potter on 12/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "BigMushroomEnemy.h"


@interface TerrainLayer: Layer
{
    TextureAtlas *atlas;
	CocosNode *voidNode;
	
	BigMushroomEnemy *bme;
	
	NSArray *allTerrainData;
	NSMutableArray *curTerrainData;
	int dataIndex;
	float curMaxXPosition;
	
	
	NSMutableArray *bounds;
}

-(NSMutableArray*)getBounds;

-(NSString*) title;
@end
