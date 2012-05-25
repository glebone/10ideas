//
//  AppDelegate.m
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "loginController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize userId;
@synthesize publicIdeas;

static AppDelegate* _appDelegate = nil;

+ (AppDelegate *) getDelegate
{
    if (!_appDelegate)
        _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return _appDelegate;
}
- (NSString *)userId {
    if (!userId)
        userId =  [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    
    return userId;
}

- (void)setUserId:(NSString *)newValue {
    [userId autorelease];
    userId = [newValue retain];
    
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:@"userId"];
}

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.publicIdeas = [Idea getRemotePublicIdeas];

    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    UINavigationController *viewController1 = [[UINavigationController alloc] initWithRootViewController:[[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease]];
    UINavigationController *viewController2 = [[UINavigationController alloc] initWithRootViewController:[[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease]];
    viewController1.navigationBarHidden = YES;
    viewController2.navigationBarHidden = YES;
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userId"])
    {
        loginController *curLogging = [[loginController alloc] initWithNibName:@"loginController" bundle:nil];
        [self.tabBarController presentModalViewController:curLogging animated:NO];
    }
     
//    NSArray * ideas = [Idea getRemoteIdeas];
//    
//    Idea *newIdea = [Idea alloc];
//    newIdea.ideaText = @"Another idea 2";
//    [newIdea sendIdea];
//    
//    [[publicArray objectAtIndex:1] rateIdea];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (NSString *) getUserId
{
    self.userId = TEMP_USER_ID;
    NSLog(@">>>> %@", self.userId);
    return self.userId;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/


@end
