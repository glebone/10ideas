//
//  Idea.h
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "AppDelegate.h"



@interface Idea : NSObject
{
    NSString *ideaText;
    NSString *ideaAuthor;
}


@property (nonatomic, retain) NSString *ideaText;
@property (nonatomic, retain) NSString *ideaAuthor;

- (id) initWithIdeaText:(NSString *) text;
+ (NSArray *) getRemoteIdeas;
+ (NSArray *) getRemotePublicIdeas;
+ (Idea *) getIdeaWithId:(NSString *)ideaId;

- (void) sendIdea;

@end
