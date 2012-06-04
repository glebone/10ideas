//
//  Idea.m
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Idea.h"
#import "SBJson.h"

@implementation Idea

@synthesize ideaText, ideaAuthor, ideaID;




+ (NSArray *)getRemoteIdeas
{
    NSString *allIdeasReq = [NSString stringWithFormat:@"%@/ideas.json?auth_token=%@",SERVER_URL, [[AppDelegate getDelegate] userId]];
    //NSMutableArray *currentIdeas = [[[NSMutableArray alloc] init] autorelease];
    
    NSLog(@"%@",allIdeasReq);
    ASIHTTPRequest *ideas_req = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:allIdeasReq]];
    [ideas_req setRequestMethod:@"GET"];
    [ideas_req setDelegate:self];
    [ideas_req addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
    [ideas_req startSynchronous];
    NSError *error = [ideas_req error];
    
    if (error) {
        NSLog(@" %@", error);
        return nil;
    }

    NSArray *parsedArray  = [[ideas_req responseString] JSONValue];
    NSMutableArray *objects = [[NSMutableArray alloc] init];

    NSLog(@"%@",objects);
    
    for (NSDictionary *item in parsedArray) 
    {
       
        [objects addObject:[Idea makeIdeaFromDictionary:item]]; 
    }
    
    
    
    return objects;
}

+ (Idea *) makeIdeaFromDictionary:(NSDictionary *)dict
{
    Idea *tmp = [[[Idea alloc] init] autorelease];
    tmp.ideaText = [dict objectForKey:@"essential"];
    tmp.ideaID = [dict objectForKey:@"_id"];
    NSLog(@"%@",tmp.ideaText);
    NSLog(@"%@",tmp.ideaID);
    
    
    return tmp;
}

+ (NSArray *)getRemotePublicIdeas
{
    NSString *allIdeasReq = [NSString stringWithFormat:@"%@/ideas/public.json?auth_token=%@",SERVER_URL, [[AppDelegate getDelegate] userId]];
    //NSMutableArray *currentIdeas = [[[NSMutableArray alloc] init] autorelease];
    
    NSLog(@"%@",allIdeasReq);
    ASIHTTPRequest *ideas_req = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:allIdeasReq]];
    [ideas_req setRequestMethod:@"GET"];
    [ideas_req setDelegate:self];
    [ideas_req addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
    [ideas_req startSynchronous];
    NSError *error = [ideas_req error];
    
    if (error) {
        NSLog(@" %@", error);
        return nil;
    }
    
    NSArray *parsedArray  = [[ideas_req responseString] JSONValue];
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    for (NSDictionary *item in parsedArray) 
    {
        [objects addObject:[Idea makeIdeaFromDictionary:item]]; 
    }
    
    return objects;}

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
    NSString *loginStr = [NSString stringWithFormat:@"%@/ideas.json?auth_token=%@", SERVER_URL, [[AppDelegate getDelegate] userId]]; 
    ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:loginStr]] autorelease];
    
    [request setPostValue:self.ideaText forKey:@"idea[essential]"];
    [request addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(ideaSent:)];
    [request setDidFailSelector:@selector(ideaFailed:)];
    [request setRequestMethod:@"POST"];
    [request startAsynchronous];
}

- (void) rateIdea
{
    NSLog(@"RateIdea");
    NSString *loginStr = [NSString stringWithFormat:@"%@/ideas/%@/vote.json?auth_token=%@", SERVER_URL, self.ideaID, [[AppDelegate getDelegate] userId]]; 
    ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:loginStr]] autorelease];
    
    
    [request addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(ideaRated:)];
    [request setDidFailSelector:@selector(ideaFailed:)];
    [request setRequestMethod:@"PUT"];
    [request startAsynchronous];
    
}

- (void) ideaSent:(ASIHTTPRequest *)req
{
    NSLog(@"Login done");
    NSError *error = [req error];
    if (!error) {
        NSString *response = [req responseString];
        NSLog(@"-- %@", response);
         [[NSNotificationCenter defaultCenter] postNotificationName:@"needUpdateIdeas" object:self];
    }
    else
    {
        NSLog(@"%@", error);
    }
    
   
}

- (void) ideaRated:(ASIHTTPRequest *)req
{
    NSLog(@"Login done");
    NSError *error = [req error];
    if (!error) {
        NSString *response = [req responseString];
        NSLog(@"-- %@", response);
        
    }
    else
    {
        NSLog(@"%@", error);
    }

}


- (void) ideaFailed:(ASIHTTPRequest *)req
{
    NSLog(@"idea failed");  
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"10ideas"
                                                      message:@"10ideas api failed!"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [message release];
}

- (void) publishIdea
{
    NSLog(@"RateIdea");
    NSString *loginStr = [NSString stringWithFormat:@"%@/ideas/%@/publish.json?auth_token=%@", SERVER_URL, self.ideaID, [[AppDelegate getDelegate] userId]]; 
    ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:loginStr]] autorelease];
    
    
    [request addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(ideaPublished:)];
    [request setDidFailSelector:@selector(ideaFailed:)];
    [request setRequestMethod:@"PUT"];
    [request startAsynchronous]; 
}

- (void) ideaPublished:(ASIHTTPRequest *)req
{
    NSLog(@"Idea published"); 
}

@end
