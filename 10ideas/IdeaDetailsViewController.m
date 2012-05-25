//
//  IdeaDetailsViewController.m
//  10ideas
//
//  Created by Comonitos Comon4ik on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IdeaDetailsViewController.h"


@implementation IdeaDetailsViewController
@synthesize ideaText;
@synthesize idea;
@synthesize rateButton;
@synthesize edit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (idea)
        ideaText.text = idea.ideaText;

    if (edit) {
        ideaText.delegate = self;
        rateButton.hidden = YES;
        ideaText.editable = YES;
        [ideaText becomeFirstResponder];
    }
}

- (void)viewDidUnload
{
    [self setIdeaText:nil];
    [self setRateButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    [ideaText release];
    [rateButton release];
    [super dealloc];
}

- (IBAction) back {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	if([text isEqualToString:@"\n"])
	{
		[textView resignFirstResponder];
		return NO;
	}
	return YES;
}

@end
