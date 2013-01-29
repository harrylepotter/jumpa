//
//  collisionphysics.m
//  Untitled
//
//  Created by Harry Potter on 24/08/09.
//  Copyright 2009 Synthesia. All rights reserved.
//

#import "collisionphysics.h"
#import "ProximityManager.h"


@implementation collisionphysics

-(id)init{
	tickctr = 0;
	self = [super init];
	
	character = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
	
	donecollide = NO;
	collisionsEnabled = YES;
	
	movementfactor = 0.0f;
	
	numCollisionsArray = [[NSMutableArray alloc] initWithCapacity:10];
	
	terrainsProximityManager = [[ProximityManager create:128] retain];
	creditsProximityManager = [[ProximityManager create:48] retain];
	oxyProximityManager = [[ProximityManager create:168] retain];
	enemyProximityManager = [[ProximityManager create:64] retain];
	
	// respond to suffocation
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(disableCollisions:)
												 name:@"disableCollisions" object:nil];
	return self;
}

-(void)resetCollisions
{
	donecollide = NO;
	collisionsEnabled = YES;	
}

-(void)disableCollisions:(NSNotification *)notification
{
	donecollide = YES;
	collisionsEnabled = NO;
}


-(void)update:(int)ticks
{
	
	[self findTerrainCollisions];
	
	[self findEnemyCollisions];
	
	[self findCreditCollisions];
	
	[self findOxyCollisions];

	[self findEndPointCheckPoints];
	
}

-(void)findEndPointCheckPoints{
	CGRect characterAbsoluteBounds = [jumpachar absoluteBounds];
	
	if(characterAbsoluteBounds.origin.x > endpoint){
		[gs levelFinished];
	}
	
	//for(int i=0; i<[checkpoints count];i++){
//		NSDictionary *curitem = [checkpoints objectAtIndex:i];
//		NSNumber *x = [curitem objectForKey:@"x"];
//		float xfloat = [x floatValue];
//		if(characterAbsoluteBounds.origin.x > xfloat){
//			//NSLog(@"checkpoint");
//			[gs hitCheckPoint:x];
//			[checkpoints removeObjectAtIndex:i];
//		}
//		
//	}
}


-(void)findEnemyCollisions{

	if(collisionsEnabled){
		CGRect characterAbsoluteBounds = [jumpachar absoluteBounds];
		
		NSMutableArray *children = [enemyProximityManager getRoughRange:characterAbsoluteBounds.origin.x 
																		y:characterAbsoluteBounds.origin.y 
																	range:4];
		//NSArray *children = [enemies children];
		
		for(int i=0;i<[children count];i++){
			animatedBoundedSprite *current = [children objectAtIndex:i];
			[current updateBounds];
					
				
			if(CGRectIntersectsRect(jumpachar.absoluteBounds, current.charbounds)){

				if(!donecollide){

					[jumpachar switchStates:7 point:ccp(jumpachar.charbounds.origin.x-50, jumpachar.charbounds.origin.y)];
					[gs stopLevel];
					donecollide = YES;
					collisionsEnabled = NO;
				}
			}
		}
	}

}

-(void)findCreditCollisions{
	
	if(collisionsEnabled){
		
		CGRect characterAbsoluteBounds = [jumpachar absoluteBounds];
		NSMutableArray *children = [creditsProximityManager getRoughRange:characterAbsoluteBounds.origin.x 
																		 y:characterAbsoluteBounds.origin.y 
																	 range:4];
		for(int i=0;i<[children count];i++){
			
			collectable *current = [children objectAtIndex:i];
			CGPoint pos = [current convertToWorldSpace:CGPointZero];
			
			CGRect charbounds = CGRectMake(pos.x, pos.y, 32, 32);
			if(CGRectIntersectsRect([jumpachar absoluteBounds], charbounds)){
				
				if([current getIsCollectable]){
					[current collect];
					[jumpachar addCreditToScore];
					//[gs addStarEmitter:ccp(pos.x+16,pos.y+16)];
				break;
				}
				


			}
		
		}
	}
	
	
}

-(void)findOxyCollisions{
	
	if(collisionsEnabled){
		
		CGRect characterAbsoluteBounds = [jumpachar absoluteBounds];
		NSMutableArray *children = [oxyProximityManager getRoughRange:characterAbsoluteBounds.origin.x 
																		y:characterAbsoluteBounds.origin.y 
																	range:2];
		for(int i=0;i<[children count];i++){
			
			collectable *current = [children objectAtIndex:i];
			CGPoint pos = [current convertToWorldSpace:CGPointZero];
			
			CGRect charbounds = CGRectMake(pos.x, pos.y, 32, 32);
			if(CGRectIntersectsRect([jumpachar absoluteBounds], charbounds)){
				
				
				if([current getIsCollectable]){
					[current collect];
					// post oxy update
					[[NSNotificationCenter defaultCenter] postNotificationName:@"oxyUpdate" object:self];
					break;
				}
				
				
			}
			
		}
	}
	
	
}

-(void)findTerrainCollisions{
	

	movementfactor += 65.0f;
	if(collisionsEnabled){
	
		//NSArray *children = [terrains children];
		CGRect characterAbsoluteBounds = [jumpachar absoluteBounds];
		
		NSMutableArray *children = [terrainsProximityManager getRoughRange:characterAbsoluteBounds.origin.x 
																   y:characterAbsoluteBounds.origin.y 
															   range:1];

		
		int numcollisions = 0;
	
		for(int i=0;i<[children count];i++){
			boundedSprite *current = [children objectAtIndex:i];

			
			CGPoint abspos = [current convertToWorldSpace:CGPointZero];
			
			CGRect absrect = CGRectMake(abspos.x,abspos.y-5, current.charbounds.size.width, current.charbounds.size.height+6);
			int spriteType = current.spriteType;
			
			

				if(CGRectIntersectsRect([jumpachar absoluteBounds], absrect)){
				
					
					if(spriteType == SPRITE_TYPE_GROUND){ // ground is different to platforms when colliding sideon
						
						if(!([self isCollisionBelowCharacter:[jumpachar absoluteBounds] collider:absrect])){
							if(!donecollide){
								[jumpachar switchStates:7 point:ccp(jumpachar.charbounds.origin.x-50, jumpachar.charbounds.origin.y)];
								[gs stopLevel];
								donecollide = YES;
								collisionsEnabled = NO;
							}
							
							
						}else{
							[jumpachar terrainCollision:ccp(jumpachar.charbounds.origin.x, current.charbounds.origin.y+ current.charbounds.size.height)];
							numcollisions++;
							break;
						}
						
					}else{
						if(([self isCollisionHalfBelowCharacter:[jumpachar absoluteBounds] collider:absrect])){
							[jumpachar terrainCollision:ccp(jumpachar.charbounds.origin.x, current.charbounds.origin.y+ current.charbounds.size.height)];
							numcollisions++;
							break;
						}
					
					}
					
					
					
					
					
				}
			
		}
		
	
		
		
		if(numcollisions < 1){ // initiate a fall
			if(jumpachar.charbounds.origin.y <= -99){
				// Kill 
				NSLog(@"collisionphysics.m : character fell below threshold %f", jumpachar.charbounds.origin.y);
				[jumpachar switchStates:7 point:ccp(jumpachar.charbounds.origin.x, jumpachar.charbounds.origin.y)]; // fall
				[gs stopLevel];
				donecollide = YES;
				collisionsEnabled = NO;
			}else{
				// fall from point
				if(!donecollide && (jumpachar.current_state != 6) && (jumpachar.current_state != 7)){ /* if character isnt dead and isnt already falling */
					
					[jumpachar terrainCollisionEnded:ccp(jumpachar.charbounds.origin.x, jumpachar.charbounds.origin.y)];
					
				}
			}
		}
										 

	}
	
	
	
}



-(BOOL)isCollisionBelowCharacter:(CGRect)base collider:(CGRect)collider{
	if((base.origin.y + 50 > (collider.origin.y + collider.size.height)) 
	   ){
		
		return YES;
	}
	
	return NO;
}

-(BOOL)isCollisionHalfBelowCharacter:(CGRect)base collider:(CGRect)collider{
// was +27
	if((base.origin.y + 50 > (collider.origin.y + collider.size.height)) 
	   ){
		return YES;
	}
	return NO;
}


-(BOOL)isCollisionToRightOfCharacter:(CGRect)base collider:(CGRect)collider{
	if((base.origin.x + (base.size.width) - 10) < collider.origin.x){
		return YES;
	}else{
		return NO;
	}
}


-(void)addTerrainLayer:(id)terrain{
	[terrainsProximityManager reset];
	
	terrains = (TerrainLayer*)terrain;
	NSArray *children = [terrains children];
	for(int i=0;i< [children count]; i++){
		[terrainsProximityManager addObject:[children objectAtIndex:i]];
	}
	[terrainsProximityManager update];
}

-(void)addEnemyLayer:(id)enemy{
	[enemyProximityManager reset];
	enemies = (EnemyLayer*)enemy;
	NSArray *children = [enemies children];
	for(int i=0;i< [children count]; i++){
		[enemyProximityManager addObject:[children objectAtIndex:i]];
	}
	[enemyProximityManager update];
}
-(void)setCharacterBounds:(CGRect)coords{
	character = coords;
}

-(void)setCharacterSprite:(id)theSprite{
	jumpachar = (JumpaCharacterLayer*)theSprite;
}

-(void)setCreditsManager:(AtlasSpriteManager*)mgr{
	[creditsProximityManager reset];
	credits = mgr;
	NSArray *children = [credits children];
	for(int i=0;i< [children count]; i++){
		[creditsProximityManager addObject:[children objectAtIndex:i]];
	}
	[creditsProximityManager update];
}

-(void)setOxyManager:(AtlasSpriteManager*)mgr{
	[oxyProximityManager reset];
	oxies = mgr;
	NSArray *children = [oxies children];
	for(int i=0;i< [children count]; i++){
		[oxyProximityManager addObject:[children objectAtIndex:i]];
	}
	[oxyProximityManager update];
}

-(void)setCheckpoints:(NSArray*)checkpointsList{
	checkpoints = [[NSMutableArray arrayWithArray:checkpointsList] retain];
}


-(void)setEndPoint:(NSNumber*)theendPoint{
	endpoint = [theendPoint floatValue];
}

-(void)setGameScene:(id)thegamescene{
	gs = thegamescene;
}



-(void)removeTerrain:(NSString*)name{
	//[terrains removeObjectForKey:name];
}
-(void)removeEnemy:(NSString*)name{
	//[enemies removeObjectForKey:name];
}

@end
