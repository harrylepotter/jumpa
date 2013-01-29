//
//  AudioConverter.m
//  Untitled
//
//  Created by harry on 18/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#define kSrcBufSize 32768
#import "AudioConverter.h"
#include <AudioToolbox/AudioToolbox.h>





// external to this file the following function needs to be defined



@implementation AudioConverter

static AudioConverter *sharedAudioConverter = nil;

+ (AudioConverter *)sharedAudioConverter {
	@synchronized(self)	{
		if (!sharedAudioConverter){
			sharedAudioConverter = [[AudioConverter alloc] init];            
        }
		return sharedAudioConverter;
	}
	// to avoid compiler warning
	return nil;
}

+ (id)alloc {
	@synchronized(self)
	{
		NSAssert(sharedAudioConverter == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedAudioConverter = [super alloc];
		return sharedAudioConverter;
	}
	// to avoid compiler warning
	return nil;
}


-(NSString*)getAudioFileReference: (NSString*)mp3File{
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *fileName = [NSString stringWithFormat:@"%@/%@.wav", 
						  documentsDirectory,mp3File];
	
	if(![self existsAsWAV:mp3File]){
		[self unpackToWAV:mp3File];
	}
	
	NSLog(@"unpacked : %@", fileName);  
	return fileName;
}

-(BOOL) existsAsWAV:(NSString*)mp3File{
	NSFileManager *fm = [NSFileManager defaultManager];
    
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *fileName = [NSString stringWithFormat:@"%@/%@.wav", 
						  documentsDirectory,mp3File];

	BOOL fileExists =  [fm fileExistsAtPath:fileName] ;
	return fileExists;
	
}

-(void) unpackToWAV:(NSString*)mp3File{
	//get the documents directory:
	NSArray *paths = NSSearchPathForDirectoriesInDomains
	(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	
	NSString *respath=[[NSBundle mainBundle] pathForResource:mp3File ofType:@"mp3"]; 
	CFURLRef inputFileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)respath, kCFURLPOSIXPathStyle, FALSE);

	
	//make a file name to write the data to using the documents directory:
	NSString *fileName = [NSString stringWithFormat:@"%@/%@.wav", 
						  documentsDirectory,mp3File];
	
	NSLog(@"written file : %@", fileName);
	
	CFURLRef outputFileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)fileName, kCFURLPOSIXPathStyle, FALSE);
	
	AudioStreamBasicDescription inputFormat;
	inputFormat.mSampleRate = 44100.0f;
	inputFormat.mFormatID = 778924083;
	inputFormat.mFormatFlags = 0;
	inputFormat.mBytesPerPacket = 0;
	inputFormat.mFramesPerPacket = 1152;
	inputFormat.mBytesPerFrame = 0;
	inputFormat.mChannelsPerFrame= 2;
	inputFormat.mBitsPerChannel = 0;
	
	AudioStreamBasicDescription outputFormat;
	outputFormat.mSampleRate = 44100.000000 ;
	outputFormat.mFormatID = 1819304813;
	outputFormat.mFormatFlags = 12;
	outputFormat.mBytesPerPacket = 4;
	outputFormat.mFramesPerPacket = 1;
	outputFormat.mBytesPerFrame = 4;
	outputFormat.mChannelsPerFrame= 2;
	outputFormat.mBitsPerChannel = 16;
	

	UInt32 outputBitRate = 0; 

	
	ExtAudioFileRef infile, outfile;
	
	// first open the input file
	OSStatus err = ExtAudioFileOpenURL (inputFileURL, &infile);
	//XThrowIfError (err, "ExtAudioFileOpen");
	
	// if outputBitRate is specified, this can change the sample rate of the output file
	// so we let this "take care of itself"
	outputFormat.mSampleRate = 0.;
	
	// create the output file (this will erase an exsiting file)
	err = ExtAudioFileCreateWithURL (outputFileURL, kAudioFileWAVEType, &outputFormat, NULL, kAudioFileFlags_EraseFile, &outfile);
	//XThrowIfError (err, "ExtAudioFileCreateNew");
	
	// get and set the client format - it should be lpcm
	AudioStreamBasicDescription clientFormat = (inputFormat.mFormatID == kAudioFormatLinearPCM ? inputFormat : outputFormat);
	UInt32 size = sizeof(clientFormat);
	err = ExtAudioFileSetProperty(infile, kExtAudioFileProperty_ClientDataFormat, size, &clientFormat);
	//XThrowIfError (err, "ExtAudioFileSetProperty inFile, kExtAudioFileProperty_ClientDataFormat");
	
	size = sizeof(clientFormat);
	err = ExtAudioFileSetProperty(outfile, kExtAudioFileProperty_ClientDataFormat, size, &clientFormat);
	//XThrowIfError (err, "ExtAudioFileSetProperty outFile, kExtAudioFileProperty_ClientDataFormat");
	
	if( outputBitRate > 0 ) {
		printf ("Dest bit rate: %d\n", (int)outputBitRate);
		AudioConverterRef outConverter;
		size = sizeof(outConverter);
		err = ExtAudioFileGetProperty(outfile, kExtAudioFileProperty_AudioConverter, &size, &outConverter);
		//XThrowIfError (err, "ExtAudioFileGetProperty outFile, kExtAudioFileProperty_AudioConverter");
		
		err = AudioConverterSetProperty(outConverter, kAudioConverterEncodeBitRate, 
										sizeof(outputBitRate), &outputBitRate);
		//XThrowIfError (err, "AudioConverterSetProperty, kAudioConverterEncodeBitRate");
		
		// we have changed the converter, so we should do this in case 
		// setting a converter property changes the converter used by ExtAF in some manner
		CFArrayRef config = NULL;
		err = ExtAudioFileSetProperty(outfile, kExtAudioFileProperty_ConverterConfig, sizeof(config), &config);
		//XThrowIfError (err, "ExtAudioFileSetProperty outFile, kExtAudioFileProperty_ConverterConfig");
	}
	
	// set up buffers
	char srcBuffer[kSrcBufSize];
	
	// do the read and write - the conversion is done on and by the write call
	while (1) 
	{	
		AudioBufferList fillBufList;
		fillBufList.mNumberBuffers = 1;
		fillBufList.mBuffers[0].mNumberChannels = inputFormat.mChannelsPerFrame;
		fillBufList.mBuffers[0].mDataByteSize = kSrcBufSize;
		fillBufList.mBuffers[0].mData = srcBuffer;
		
		// client format is always linear PCM - so here we determine how many frames of lpcm
		// we can read/write given our buffer size
		UInt32 numFrames = (kSrcBufSize / clientFormat.mBytesPerFrame);
		
		// printf("test %d\n", numFrames);
		
		err = ExtAudioFileRead (infile, &numFrames, &fillBufList);
		//XThrowIfError (err, "ExtAudioFileRead");	
		if (!numFrames) {
			// this is our termination condition
			break;
		}
		
		err = ExtAudioFileWrite(outfile, numFrames, &fillBufList);	
		//XThrowIfError (err, "ExtAudioFileWrite");	
	}
	
	// close
	ExtAudioFileDispose(outfile);
	ExtAudioFileDispose(infile);
	
	

	
}







@end
