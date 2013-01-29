//
//  MusicFadeAction.h
//  Untitled
//
//  Created by harry on 19/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MusicFadeAction : IntervalAction {
	float fadefrom;
	float fadeto; 
	id musictarget;
	SEL getter;
	SEL setter;
}
+(id) actionWithDuration: (ccTime) t fadeTo:(float)to property:(NSString*)prop musicItem:(id)tgt;
-(id) initWithDuration: (ccTime) t fadeTo:(float)to property:(NSString*)prop musicItem:(id)tgt;

@end
