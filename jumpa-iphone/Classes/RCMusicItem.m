//
//  RCMusicItem.m
//  Untitled3
//
//  Created by harry on 18/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RCMusicItem.h"
#import "AudioConverter.h"

@implementation RCMusicItem

-(id)initWithFile: (NSString*)fileName{
	self = [super init];

	
	NSString *respath= [[AudioConverter sharedAudioConverter] getAudioFileReference:fileName];
	NSLog(@"respath = %@", respath);
	
	if([[[UIApplication sharedApplication] delegate] hasFastCPU]){
		channel = BASS_StreamCreateFile(FALSE,[respath UTF8String],0,0,BASS_SAMPLE_FLOAT|BASS_STREAM_DECODE);
		channel = BASS_FX_TempoCreate(channel, BASS_SAMPLE_LOOP|BASS_FX_FREESOURCE);
	}else{
		channel = BASS_StreamCreateFile(FALSE,[respath UTF8String],0,0,BASS_SAMPLE_LOOP);
	}
	
	eq.fResonance = 2.12f;
	eq.fCutOffFreq = 8000.0f;
	eq.lChannel = 1|2;
	
	cutoffFrequency = [[NSNumber numberWithFloat:8000.0f] retain];
	resonance = [[NSNumber numberWithFloat:2.12f] retain];
	frequency = [[NSNumber numberWithFloat:44100.0f] retain];
	volume = [[NSNumber numberWithFloat:1.0f] retain];
	
	if([[[UIApplication sharedApplication] delegate] hasFastCPU]){
		lpfFX = BASS_ChannelSetFX(channel, BASS_FX_BFX_LPF, 10);
		BASS_FXSetParameters(lpfFX, &eq);	
	}
	return self;
}

-(void)play{
BASS_ChannelPlay(channel,TRUE);

}

-(void)resume{
		BASS_ChannelPlay(channel,FALSE);
}


-(void)pause{
	BASS_ChannelPause(channel);
}

-(void)stop{
	BASS_ChannelStop(channel);

}


-(void)setCutoffFrequency: (NSNumber*)cutoff{
	cutoffFrequency = [cutoff retain];
	eq.fCutOffFreq = [cutoff floatValue];
	BASS_FXSetParameters(lpfFX, &eq);	

}


-(void)setResonance: (NSNumber*)theresonance{
	resonance = [theresonance retain];
	eq.fResonance = [theresonance floatValue];
	BASS_FXSetParameters(lpfFX, &eq);	

}


-(void)setFrequency: (NSNumber*)freq{
	frequency = [freq retain];
	float f_frequency = [freq floatValue];
	BASS_ChannelSetAttribute(channel, BASS_ATTRIB_TEMPO_FREQ, f_frequency);

}

-(void)setVolume: (NSNumber*)vol{
	volume = [vol retain];
	float f_vol = [volume floatValue];
	BASS_ChannelSetAttribute(channel, BASS_ATTRIB_VOL, f_vol);

}


-(NSNumber*)getCutoffFrequency{
	return cutoffFrequency;
}
-(NSNumber*)getResonance{
	return resonance;
}
-(NSNumber*)getFrequency{
	return frequency;
}
-(NSNumber*)getVolume{
	return volume;
}

@end
