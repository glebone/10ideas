//
//  SecondViewController.h
//  10ideas
//
//  Created by gleb dobzhanskiy on 25.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdeaDetailsViewController.h"

@interface SecondViewController : UIViewController
{
    UILabel *ideasCount;
    UILabel *ideasLabel;
}
@property (retain, nonatomic) IBOutlet UILabel *ideasCount;
@property (retain, nonatomic) IBOutlet UILabel *ideasLabel;
- (IBAction)handleCreateIdea:(id)sender;

@end
