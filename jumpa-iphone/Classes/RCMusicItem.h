//
//  RCMusicItem.h
//  Untitled3
//
//  Created by harry on 18/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bass.h"
#import "bass_fx.h"

@interface RCMusicItem : NSObject {
	HSTREAM *channel;
	float freq;
	float gain;

	
	BASS_BFX_LPF eq;
	HFX lpfFX;
	
	NSNumber *cutoffFrequency;
	NSNumber *resonance;
	NSNumber *frequency;
	NSNumber *volume;

}

-(void)play;

-(void)resume;

-(void)pause;

-(void)stop;


-(void)setCutoffFrequency: (NSNumber*)cutoff;

-(void)setResonance: (NSNumber*)resonance;

-(void)setFrequency: (NSNumber*)freq;

-(void)setVolume: (NSNumber*)volume;

-(NSNumber*)getCutoffFrequency;
-(NSNumber*)getResonance;
-(NSNumber*)getFrequency;
-(NSNumber*)getVolume;


@end
