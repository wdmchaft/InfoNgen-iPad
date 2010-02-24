//
//  SearchResult.h
//  InfoNgen-Basic
//
//  Created by Robert Stewart on 2/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SearchResult : NSObject <NSCoding, NSCopying> {
	NSString * headline;
	NSString * synopsis;
	NSDate * date;
	NSString * url;
	NSString * notes;
	UIImage * image;
}

@property(nonatomic,retain) NSString * headline;
@property(nonatomic,retain) NSString * synopsis;
@property(nonatomic,retain) NSString * url;
@property(nonatomic,retain) NSDate * date;
@property(nonatomic,retain) NSString * notes;
@property(nonatomic,retain) UIImage * image;

- (id) initWithHeadline:(NSString *)theHeadline withUrl:(NSString *) theUrl withSynopsis:(NSString*)theSynopsis withDate:(NSDate*)theDate;


@end
