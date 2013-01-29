//
//  main.m
//  jumpa
//
//  Created by harry on 5/10/09.
//  Copyright __ORGANIZATIONNAME2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil,
								   @"jumpaAppDelegate");
	[pool release];
	return retVal;
}
