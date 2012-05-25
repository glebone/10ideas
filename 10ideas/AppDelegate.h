//
//  AppDelegate.h
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Idea.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

{
    NSString *userId; 
    NSArray *publicIdeas;
    NSArray *myIdeas;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *userId;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (nonatomic, retain) NSArray *publicIdeas;
@property (nonatomic, retain) NSArray *myIdeas;


+ (AppDelegate *) getDelegate;

- (NSString *) getUserId;

- (NSString *)userId;

- (void)setUserId:(NSString *)newValue;

@end
