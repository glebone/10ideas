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
    NSString *allIdeasReq = [NSString stringWithFormat:@"%@/ideas.json?auth_token=%@",SERVER_URL, @"NeFzqZqWDR6V3XQbn84Y"];
    //NSMutableArray *currentIdeas = [[[NSMutableArray alloc] init] autorelease];
    
    NSLog(@"%@",allIdeasReq);
    ASIHTTPRequest *ideas_req = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:allIdeasReq]];
    [ideas_req setRequestMethod:@"GET"];
    [ideas_req setDelegate:self];
    [ideas_req addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
    [ideas_req startSynchronous];
    NSError *error = [ideas_req error];
    if (!error) {
        NSString *response = [ideas_req responseString];
        NSLog(@"%@",response);
    } 
    else
    {
        NSLog(@" %@", error);
    }
    
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
