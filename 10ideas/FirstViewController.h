//
//  FirstViewController.h
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdeaDetailsViewController.h"

@interface FirstViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *table;
}
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (retain, nonatomic) IBOutlet UILabel *ideasCount;
@property (retain, nonatomic) IBOutlet UILabel *ideasLabel;


- (void) reloadDataView;

@end