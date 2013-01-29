//
//  jumpaMoviePlayer.h
//  Untitled
//
//  Created by harry on 4/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface jumpaMoviePlayer : NSObject {
	MPMoviePlayerController *mMoviePlayer;
    NSURL *mMovieURL;
	
}

@end
