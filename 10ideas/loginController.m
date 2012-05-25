//
//  loginController.m
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "loginController.h"

@implementation loginController
@synthesize loginButton, emailText, passwordText, logView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)OnLogin:(id)sender
{
    if (![self.emailText.text isEqualToString:@""] && ![self.passwordText.text isEqualToString:@""])
    {
        NSString *loginStr = [NSString stringWithFormat:@"%@/users.json", SERVER_URL]; 
        ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:loginStr]] autorelease];
        
        [request setPostValue:self.emailText.text forKey:@"user[email]"];
        [request setPostValue:self.passwordText.text forKey:@"user[password]"];
        [request addRequestHeader:@"User-Agent" value:@"ZX-Spectrum"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(loginDone:)];
        [request setDidFailSelector:@selector(loginFailed:)];
        [request setRequestMethod:@"POST"];
        [request startAsynchronous];
    }
    NSLog(@"on logging");
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void) loginDone:(ASIHTTPRequest *)req
{
    NSLog(@"Login done");
    NSError *error = [req error];
    if (!error) {
        NSString *response = [req responseString];
        NSLog(@"-- %@", response);
        NSDictionary *parsedDic  = [response JSONValue];
        if ([parsedDic objectForKey:@"auth_token"])
        {    
         [[AppDelegate getDelegate] setUserId:[parsedDic objectForKey:@"auth_token"]];
         [self.view removeFromSuperview];
             NSLog(@"%@", [parsedDic objectForKey:@"auth_token"]);
            NSLog(@"%@", [[AppDelegate getDelegate] getUserId]);   
        }    
        
    }
    else
    {
        NSLog(@"%@", error);
    }

    
}

- (void) loginFailed:(ASIHTTPRequest *)req
{
    NSLog(@"Login Failed");
}

@end
