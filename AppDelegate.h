//
//  AppDelegate.h
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

{
    NSString *userId;   
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *userId;
@property (strong, nonatomic) UITabBarController *tabBarController;

+ (AppDelegate *) getDelegate;

- (NSString *) getUserId;

@end
