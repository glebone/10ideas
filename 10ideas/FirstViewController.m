//
//  FirstViewController.m
//  10ideas
//
//  Created by gleb dobzhanskiy on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize table;
@synthesize ideasCount;
@synthesize ideasLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Public", @"Public");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int count = [[[AppDelegate getDelegate] publicIdeas] count];
    ideasCount.text = [NSString stringWithFormat:@"%d",count];
    if (count == 1)
        ideasLabel.text = @"Public idea";
}

#pragma mark - TABLE VIEW
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AppDelegate getDelegate] publicIdeas] count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *reuseIdentefire = @"ideaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentefire];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentefire];
    
    Idea *idea = [[[AppDelegate getDelegate] publicIdeas] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = idea.ideaText;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Idea №%d",indexPath.row+1];
    
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Idea *idea = [[[AppDelegate getDelegate] publicIdeas] objectAtIndex:indexPath.row];
    IdeaDetailsViewController *details = [[[IdeaDetailsViewController alloc] initWithNibName:@"IdeaDetailsViewController" bundle:nil] autorelease];
    
    details.idea = idea;
    
    [self.navigationController pushViewController:details animated:YES];
    
}


@end
