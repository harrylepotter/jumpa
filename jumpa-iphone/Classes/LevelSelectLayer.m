//
//  LevelSelectLayer.m
//  menu
//
//  Created by harry on 30/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectLayer.h"
#import "SFXManager.h"

@implementation LevelSelectLayer

-(id)initWithStates:(NSMutableDictionary*)states
{
	
	NSLog(@"LevelSelectLayer : init");
	self = [super init];
	
	
	unlockStates = [states retain];
	
	
	easy = [[[easymenuitem alloc] init] retain];
	easy.transformAnchor = ccp(0,0);
	easy.position = ccp(37, 140);
	[easy setButtonState:[[states objectForKey:@"easy"] intValue]];
	[self addChild:easy];
	
	
	medium = [[[mediummenuitem alloc] init] retain];
	medium.transformAnchor = ccp(0,0);
	medium.position = ccp(138, 135);
	[medium setButtonState:[[states objectForKey:@"medium"] intValue]];
	[self addChild:medium];	
	
	hard = [[[hardmenuitem alloc] init] retain];
	hard.transformAnchor = ccp(0,0);
	hard.position = ccp(240, 132);
	[hard setButtonState:[[states objectForKey:@"hard"] intValue]];
	[self addChild:hard];	
	
	extreme = [[[extememenuitem alloc] init] retain];
	extreme.transformAnchor = ccp(0,0);
	extreme.position = ccp(345, 130);
	[extreme setButtonState:[[states objectForKey:@"extreme"] intValue]];
	[self addChild:extreme];
	
	isTouchEnabled = YES;
	
	items = [[NSArray arrayWithObjects:easy, medium, hard, extreme, nil] retain];
	
	return self;
	
}



-(NSMutableDictionary*)unlockStates{
	return unlockStates;
}

-(void)setUnlockStates:(NSMutableDictionary*)states{
	unlockStates = states;
	
	[easy setButtonState:[[states objectForKey:@"easy"] intValue]];
	[medium setButtonState:[[states objectForKey:@"medium"] intValue]];
	[hard setButtonState:[[states objectForKey:@"hard"] intValue]];
	[extreme setButtonState:[[states objectForKey:@"extreme"] intValue]];
	
}




- (BOOL)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

	NSLog(@"levelselectLayer: touches ended");

	for(int i=0; i<[items count]; i++){
		difficultymenuitem *item = [items objectAtIndex:i];
		if ([item getButtonState] == STATE_UNLOCKED_PRESSED){
			[item setButtonState:STATE_UNLOCKED];
			[self loadLevel:i];
		}else if([item getButtonState] == STATE_UNLOCKED_WON_PRESSED){
			[item setButtonState:STATE_UNLOCKED_WON];
			[self loadLevel:i];
		}	
	}
	
	
	return kEventHandled;
}

-(void)loadLevel:(int)level{
	switch(level){
		case 0: NSLog(@"load easy level"); [self loadLevelWithString:@"easy"]; break;
		case 1: NSLog(@"load medium level"); [self loadLevelWithString:@"medium"]; break;
		case 2: NSLog(@"load hard level"); [self loadLevelWithString:@"hard"]; break;
		case 3: NSLog(@"load extreme level"); [self loadLevelWithString:@"extreme"];break;
	}
	
	
}

-(void)loadLevelWithString:(NSString*)level{
	
	if([[[UIApplication sharedApplication] delegate] loadInternetLevels]){
		[self loadLevelFromInternet];
		return;
	}
	
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *plistPath = [bundle pathForResource:level ofType:@"plist"];
	NSDictionary *level1Dictionary = [[[NSDictionary alloc] initWithContentsOfFile:plistPath] retain];
	
	GameScene *gs = [[[UIApplication sharedApplication] delegate] getSharedGameScene];
	NSLog(@"plist path = %@", level);
	
	[gs setLevel:level1Dictionary name:level];
	
	[[Director sharedDirector] replaceScene:gs];
	[gs startGame];
	
}

-(void)loadLevelFromInternet{
	
	responseData = [[NSMutableData data] retain];
	
	NSMutableURLRequest *request =
	[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.apprepublik.com/jumpa/level.plist"]];
	[request setHTTPMethod:@"GET"];
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
	
	NSURLResponse *response = [NSURLResponse alloc];
	NSError *error = [NSError alloc];
	responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if(responseData != nil){
		
		NSString *string = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		NSDictionary *level1Dictionary = [[string propertyList] retain];
		
		GameScene *gs = [[[UIApplication sharedApplication] delegate] getSharedGameScene];
		[gs setLevel:level1Dictionary name:@"internet"];
		
		[[Director sharedDirector] replaceScene:gs];
		[gs startGame];
		
	}
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	NSLog(@"connectiondidReceiveResponse");
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSLog(@"connectionDidReceiveData");
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"connection failed");
    // Show error
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"FINISHED LOADING");
    // Once this method is invoked, "responseData" contains the complete result
}

- (BOOL)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"levelselectlayer: touchesbegan");
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView: [touch view]];
	touchLocation = [[Director sharedDirector] convertCoordinate: touchLocation];
	NSLog(@"touchlocation: %f,%f", touchLocation.x, touchLocation.y);
	
	
	CGPoint p = [self position];
	
	for(int i=0; i<[items count]; i++){
		difficultymenuitem *item = [items objectAtIndex:i];
		CGSize size = [item contentSize];
		CGRect mgrRect = CGRectMake(item.position.x, item.position.y, size.width, size.height);
		if( CGRectContainsPoint( mgrRect, touchLocation ) ) {
			NSLog(@"%@", item);
			NSLog(@"%f, %f", size.width, size.height);
			if ([item getButtonState] == STATE_UNLOCKED){
				[item setButtonState:STATE_UNLOCKED_PRESSED];
				[[SFXManager sharedSoundManager] playSound:@"menutouch" atPosition:CGPointZero];
			}else if([item getButtonState] == STATE_UNLOCKED_WON){
				[item setButtonState:STATE_UNLOCKED_WON_PRESSED];
				[[SFXManager sharedSoundManager] playSound:@"menutouch" atPosition:CGPointZero];	
			}
		}
	}
	

	
	return kEventHandled;
}


@end
