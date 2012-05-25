//
//  SecondViewController.m
//  10ideas
//
//  Created by gleb dobzhanskiy on 25.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
@synthesize ideasCount;
@synthesize ideasLabel;
@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Private", @"Private");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadDataView) name:@"myUpdated" object:nil];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateCount];
}
- (void) updateCount {
    int count = [[[AppDelegate getDelegate] myIdeas] count];
    ideasCount.text = [NSString stringWithFormat:@"%d",count];
    
    
    if (10 - count <= 0)
        count = 0;
    else 
        count = 10 - count;
    
    if (count == 1) 
    {
        ideasCount.text = @"1";
        ideasLabel.text = @"Idea left";
    }
    else 
    {
        ideasCount.text = [NSString stringWithFormat:@"%d",count];
        ideasLabel.text = @"Ideas left";
    }
}

#pragma mark - TABLE VIEW
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[AppDelegate getDelegate] myIdeas] count];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *reuseIdentefire = @"ideaCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentefire];
    
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentefire];
    
    Idea *idea = [[[AppDelegate getDelegate] myIdeas] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = idea.ideaText;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Idea №%d",indexPath.row+1];
    
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Idea *idea = [[[AppDelegate getDelegate] myIdeas] objectAtIndex:indexPath.row];
    IdeaDetailsViewController *details = [[[IdeaDetailsViewController alloc] initWithNibName:@"IdeaDetailsViewController" bundle:nil] autorelease];
    
    details.idea = idea;
    details.edit = YES;
    
    [self.navigationController pushViewController:details animated:YES];
    
}
- (IBAction)handleCreateIdea:(id)sender {
    IdeaDetailsViewController *details = [[[IdeaDetailsViewController alloc] initWithNibName:@"IdeaDetailsViewController" bundle:nil] autorelease];
    
    details.idea = nil;
    details.edit = YES;
    
    [self.navigationController pushViewController:details animated:YES];
}

- (void) reloadDataView
{
    [self.table reloadData];
    [self updateCount];
}

@end
