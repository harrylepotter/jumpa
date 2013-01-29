//
//  silhouettelayer.m
//  jumpa
//
//  Created by harry on 22/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "silhouettelayer.h"


@implementation silhouettelayer

-(id)init{
	self = [super init];
	Sprite *mushimage;
	
	for(int i=0;i<16;i++){
		NSString *imagename = [[NSString alloc] initWithFormat:@"mushroom_%d.png", i];
		// Top Layer, a simple image
		mushimage = [Sprite spriteWithFile:imagename];
		// scale the image (optional)
		mushimage.scale = 1.0f;
		// change the transform anchor point to 0,0 (optional)
		mushimage.transformAnchor = ccp(0,0);
		// position the image somewhere (optional)
		mushimage.position = ccp(1.0*((160*i)),-230);
		// top image is moved at a ratio of 3.0x, 2.5y
		//[mushroomscenery addChild:mushimage z:2 parallaxRatio:ccp(1.0f,1.0f)];
		[self addChild:mushimage];
	}
	
	return self;
	
	
	
}

- (void) setOpacity: (GLubyte)newOpacity
{

	NSArray *children;
	
	children = [self children];
	NSLog(@"Setopacity %d", [children count]);
	for(int i=0;i< [children count];i++){
		Sprite *current = [children objectAtIndex:i];
		[current setOpacity:newOpacity];
	}

	
}

@end
