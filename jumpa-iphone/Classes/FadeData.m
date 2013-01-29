//
//  FadeData.m
//  jumpa
//
//  Created by harry on 30/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FadeData.h"


@implementation FadeData
@synthesize gainVals;
@synthesize currentIndex;

- (void)dealloc {
    [gainVals release];
	[super dealloc];
}

@end
