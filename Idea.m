//
//  Idea.m
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Idea.h"

@implementation Idea

@synthesize ideaText, ideaAuthor;




+ (NSArray *)getRemoteIdeas
{
    NSArray * ideas = [[[NSArray alloc] initWithObjects:nil] autorelease];
    return ideas;
}

+ (NSArray *)getRemotePublicIdeas
{
    NSArray * ideas = [[[NSArray alloc] initWithObjects:nil] autorelease];
    return ideas;
}

+ (Idea *) getIdeaWithId:(NSString *)ideaId
{
    Idea *newIdea = [[[Idea alloc] initWithIdeaText:@"Hello!"] autorelease];
    return newIdea;
}

- (id) initWithIdeaText:(NSString *)text
{
    self = [super init];
    
    if (self) 
	{
        self.ideaText = text;
        self.ideaAuthor = @"iOS client";
    }
    return self;
}

- (void) sendIdea
{
    NSLog(@"Sending idea...");
}

@end
