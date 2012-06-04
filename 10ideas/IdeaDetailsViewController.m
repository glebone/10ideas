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
@synthesize saveButton;
@synthesize edit;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (idea)
        ideaText.text = idea.ideaText;
    else {
        isNew = YES;
        ideaText.text = @"";
        saveButton.enabled = YES;
        saveButton.enabled = YES;
         ideaText.delegate = self;
         rateButton.hidden = YES;
         ideaText.editable = YES;
         [ideaText becomeFirstResponder];
        
    }

    if (edit) {
        /*saveButton.enabled = YES;
        ideaText.delegate = self;
        rateButton.hidden = YES;
        ideaText.editable = YES;
        [ideaText becomeFirstResponder];*/
        [self.rateButton setTitle:@"Publish" forState:UIControlStateNormal];
    }
    else
    {
        
    }
}

- (void)viewDidUnload
{
    [self setIdeaText:nil];
    [self setRateButton:nil];
    [self setSaveButton:nil];
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

- (IBAction)rate:(id)sender {
    if (self.edit)
    {
        [idea publishIdea];
    }
    else
    {
      [idea rateIdea];
      [self.rateButton setEnabled:NO]; 
    }    
}
- (IBAction) save {
    if ([ideaText.text length] == 0)
        return;
    
    idea = [[Idea alloc] initWithIdeaText:ideaText.text];
    
    [idea sendIdea];
    
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
