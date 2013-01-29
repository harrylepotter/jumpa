//
//  collisionphysics.h
//  Untitled
//
//  Created by Harry Potter on 24/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#import "cocos2d.h"
#include "chipmunk.h"
#include "TerrainLayer.h"
#include "EnemyLayer.h"
#include "JumpaCharacterLayer.h"
#include "ProximityManager.h"
#import "collectable.h"

@interface collisionphysics : NSObject {

	
	CGRect character;
	JumpaCharacterLayer *jumpachar;
	//id jumpachar
	TerrainLayer *terrains;
	EnemyLayer *enemies;
	id gs; // gamescene
	float movementfactor;
	AtlasSpriteManager *credits;
	AtlasSpriteManager *oxies;
	AtlasSpriteManager *lives;
	
	NSMutableArray *checkpoints;
	
	BOOL donecollide;
	BOOL collisionsEnabled;
	
	int tickctr;
	
	NSMutableArray *numCollisionsArray;
	
	ProximityManager *terrainsProximityManager;
	ProximityManager *creditsProximityManager;
	ProximityManager *oxyProximityManager;
	ProximityManager *enemyProximityManager;
	
	float endpoint;
}
@property (nonatomic, retain) NSMutableDictionary *enemies;
@property (nonatomic, retain) NSMutableDictionary *terrains;

-(void)addTerrainLayer:(id)terrain;
-(void)addEnemyLayer:(id)enemy;
-(void)setCharacterBounds:(CGRect)coords;
-(void)removeTerrain:(NSString*)name;
-(void)removeEnemy:(NSString*)name;



@end
