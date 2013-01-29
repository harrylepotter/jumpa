//
//  SFXManager.m
//  jumpa
//
//  Created by harry on 14/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SFXManager.h"
#include <math.h>

@implementation SFXManager

static SFXManager *sharedSoundManager = nil;
static NSMutableDictionary *soundSet = nil;
+ (SFXManager *)sharedSoundManager {
	@synchronized(self)	{
		if (!sharedSoundManager){
			sharedSoundManager = [[SFXManager alloc] init];            
        }
		return sharedSoundManager;
	}
	// to avoid compiler warning
	return nil;
}


-(id)init
{
	 self = [super init];
	soundSet = [[NSMutableDictionary alloc] initWithCapacity:50];
	// init sound manager/OpenAL support
	[PASoundMgr sharedSoundManager];
	music_pitch = 1.0f;

	return self;
	
}




-(void)addSound: (NSString*)sound gain:(NSNumber*)gainValue
{
	NSLog(@"SFXMANAGER: Addsound : %@", sound);
	
	PASoundSource *source1 = [[[PASoundMgr sharedSoundManager] addSound:sound withExtension:@"ogg" position:CGPointZero looped:NO] retain];
	[source1 setGain:[gainValue floatValue]];
	[soundSet setObject:source1 forKey:sound];
	
	
}

-(void)addSound: (NSString*)sound gain:(NSNumber*)gainValue looped:(BOOL)looped
{
	NSLog(@"SFXMANAGER: Addsoundwithloopedoption : %@", sound);
	if([soundSet objectForKey:sound] == nil){
		PASoundSource *source1 = [[[PASoundSource alloc] initWithFile:sound extension:@"ogg" looped:looped] retain];
		[source1 setGain:[gainValue floatValue]];
		
		
		[soundSet setObject:source1 forKey:sound];
	}
}


-(void)addLoop:(NSString*)sound gain:(NSNumber*)gain
{
	PASoundSource *bgTrack;
	bgTrack = [[PASoundMgr sharedSoundManager] addSound:sound withExtension:@"ogg" position:CGPointZero looped:YES];
	[bgTrack setGain:[gain floatValue]];
	[bgTrack setPitch:0.7f];
}

-(void)playLoop:(NSString*)sound
{
	[[PASoundMgr sharedSoundManager] play:sound withExtension:@"ogg"];
}

-(void)playSound: (NSString*)sound atPosition:(CGPoint)pos
{

	if(![sound isEqualToString:@"credit"])
		[self stopLoops];
	
	PASoundSource *source = [soundSet objectForKey:sound];
	[source playAtPosition:ccp(pos.y, pos.x)];
}

-(void)stopSound: (NSString*)sound
{
	PASoundSource *source = [soundSet objectForKey:sound];
	[source stop];
}


-(void)stopLoops{
	[[PASoundMgr sharedSoundManager] stop:@"Run" withExtension:@"ogg"];
}

-(void)credit{
	[[[PASoundMgr sharedSoundManager] sound:@"credit" withExtension:@"ogg"] playWithRestart:YES];
}

-(void)setMusic:(NSString*)sound
{
	//PASoundSource *source1 = [[[PASoundSource alloc] initWithFile:@"level1-song1" extension:@"ogg" looped:YES] retain];
	//[soundSet setObject:source1 forKey:@"music"];
}

-(void)playMusic
{
	
	
	NSString *respath=[[NSBundle mainBundle] pathForResource:@"level1" ofType:@"wav"]; // get path of audio file
	
	chan = BASS_StreamCreateFile(FALSE,[respath UTF8String],0,0,BASS_SAMPLE_FLOAT|BASS_STREAM_DECODE);
	chan=BASS_FX_TempoCreate(chan, BASS_SAMPLE_LOOP|BASS_FX_FREESOURCE);
	BASS_ChannelPlay(chan,FALSE);

	
}

-(void)windDownMusic{
	//NSLog(@"WindDownMusic");
	
}
	






				 
@end
