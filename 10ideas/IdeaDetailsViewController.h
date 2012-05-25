//
//  IdeaDetailsViewController.h
//  10ideas
//
//  Created by Comonitos Comon4ik on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Idea.h"
@interface IdeaDetailsViewController : UIViewController <UITextViewDelegate>
{
    Idea *idea;
    BOOL edit;
}
@property BOOL edit;
@property (retain, nonatomic) IBOutlet UITextView *ideaText;
@property (nonatomic, retain) Idea *idea;
@property (retain, nonatomic) IBOutlet UIButton *rateButton;

- (IBAction) back;

@end
