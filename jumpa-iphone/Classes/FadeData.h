//
//  FadeData.h
//  jumpa
//
//  Created by harry on 30/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PASoundSource.h"


@interface FadeData : NSObject {
	NSMutableArray *gainVals;
	int currentIndex;
}

@property(nonatomic, retain) NSMutableArray *gainVals;
@property int currentIndex;

@end
