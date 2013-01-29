//
//  creditMeterLayer.m
//  jumpa
//
//  Created by harry on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "creditMeterLayer.h"


@implementation creditMeterLayer

static creditMeterLayer *sharedCreditMeter = nil;


+ (creditMeterLayer *)sharedCreditMeter {
	@synchronized(self)	{
		if (!sharedCreditMeter){
			sharedCreditMeter = [[creditMeterLayer alloc] init];            
        }
		return sharedCreditMeter;
	}
	// to avoid compiler warning
	return nil;
}

-(id) init
{
	if( ![super init] )
		return nil;
	
	livesHUD1 = [Sprite spriteWithFile:@"hudtop_0.png"];
	livesHUD1.transformAnchor = ccp(0,0);
	livesHUD1.position = ccp(0,285);
	[self addChild:livesHUD1];
	

	livesHUD2 = [Sprite spriteWithFile:@"hudtop_1.png"];
	livesHUD2.transformAnchor = ccp(0,0);
	livesHUD2.position = ccp(0,285);
	[self addChild:livesHUD2];	
	
	livesHUD3_mgr = [[AtlasSpriteManager spriteManagerWithFile:@"hudtop_2.png" capacity:1] retain];
	livesHUD3 = [[AtlasSprite spriteWithRect:CGRectMake(0, 0, 480, 35) spriteManager:livesHUD3_mgr] retain];
	livesHUD3.transformAnchor = ccp(0,0);
	livesHUD3.position = ccp(0,285);
	[livesHUD3_mgr addChild:livesHUD3];
	[self addChild:livesHUD3_mgr];
	
	CGRect newTextureRect = CGRectMake(0, 0, 79, 35);
	[livesHUD3 setTextureRect:newTextureRect];
	livesHUD3.position = ccp(0,285);
	
	Sprite *bottom = [Sprite spriteWithFile:@"hudtop_0.png"];
	bottom.transformAnchor = ccp(0,0);
	bottom.position = ccp(0,0);
	[self addChild:bottom];
	
//	[(AtlasSprite*)livesHUD2 setTextureRect: newTextureRect];
//	
	
	
	
	return self;

}

-(void)setCreditsPercentage:(NSNumber*)percent{
	CGRect newTextureRect = CGRectMake(0, 0, 79 + ([percent floatValue]*344), 35);
	[livesHUD3 setTextureRect:newTextureRect];
	livesHUD3.position = ccp(0,285);
}

@end
