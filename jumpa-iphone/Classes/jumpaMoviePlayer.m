//
//  jumpaMoviePlayer.m
//  Untitled
//
//  Created by harry on 4/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "jumpaMoviePlayer.h"
#import "jumpaAppDelegate.h"

@implementation jumpaMoviePlayer
	

-(id)init
{
	self = [super init];
	[self initMoviePlayer];
	return self;
}
#pragma mark Movie Player Routines


//  Notification called when the movie finished preloading.
- (void) moviePreloadDidFinish:(NSNotification*)notification
{
    /* 
	 < add your code here >
	 */
}

//  Notification called when the movie finished playing.
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{	
	jumpaAppDelegate *appDelegate = (jumpaAppDelegate *)[UIApplication sharedApplication].delegate;
	[appDelegate runMenuScene];
	
}

//  Notification called when the movie scaling mode has changed.
- (void) movieScalingModeDidChange:(NSNotification*)notification
{
    /* 
	 < add your code here >
	 
	 For example:
	 MPMoviePlayerController* theMovie=[aNotification object];
	 etc.
	 */
}

-(void)initMoviePlayer
{

    // Register to receive a notification when the movie is in memory and ready to play.
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePreloadDidFinish:) 
												 name:MPMoviePlayerContentPreloadDidFinishNotification 
											   object:nil];

    mMoviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[self movieURL]];
	
    // Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:mMoviePlayer];
	
    // Register to receive a notification when the movie scaling mode has changed. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(movieScalingModeDidChange:) 
												 name:MPMoviePlayerScalingModeDidChangeNotification 
											   object:mMoviePlayer];
	
	
	//mMoviePlayer.movieControlMode = MPMovieControlModeHidden;
	
	
}


-(void)playMovie
{

	
    [mMoviePlayer play];
    

}


// return a URL for the movie file in our bundle
-(NSURL *)movieURL
{
    if (mMovieURL == nil)
    {
        NSBundle *bundle = [NSBundle mainBundle];
        if (bundle) 
        {
            NSString *moviePath = [bundle pathForResource:@"intro2" ofType:@"m4v"];
            if (moviePath)
            {
                mMovieURL = [NSURL fileURLWithPath:moviePath];
                [mMovieURL retain];
            }
        }
    }
    
    return mMovieURL;
}


- (void)dealloc {
    
    [mMovieURL release];
    
    // remove movie notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerContentPreloadDidFinishNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:mMoviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerScalingModeDidChangeNotification
                                                  object:mMoviePlayer];

    // free our movie player
    [mMoviePlayer release];
    
    [super dealloc];
}






@end
