//
//  SFXManager.h
//  jumpa
//
//  Created by harry on 14/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PASoundMgr.h"
#import "PASoundSource.h"
#import "cocos2d.h"
#import "FadeData.h"
#import "bass.h"
#import "bass_fx.h"


@class PASoundSource;

@interface SFXManager : Layer {
	
	float music_pitch;
	
	HSTREAM chan;
	
}
+ (SFXManager *)sharedSoundManager;




@end
