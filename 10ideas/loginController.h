//
//  loginController.h
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "AppDelegate.h"
#import "NSObject+SBJson.h"

@interface loginController : UIViewController
{
 @private

 UIButton *loginButton;
 UITextField *emailText;
 UITextField *passwordText;
    UIView *logView;   
}


@property (nonatomic, retain) IBOutlet UIButton *loginButton;
@property (nonatomic, retain) IBOutlet UITextField *emailText;
@property (nonatomic, retain) IBOutlet UITextField *passwordText;
@property (nonatomic, retain) IBOutlet UIView *logView;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)OnLogin:(id)sender;
- (void) loginDone:(ASIHTTPRequest *)req;
- (void) loginFailed:(ASIHTTPRequest *)req;

@end
