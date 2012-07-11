//
//  ProjectViewController.m
//  InterviewCache
//
//  Created by Phx Lin. on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectTableCell.h"
#import "PeopleViewController.h"

@interface ProjectViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableDictionary *projectDictionary;
@end

@implementation ProjectViewController
@synthesize projectList = _projectList;
@synthesize projectDictionary = _prjectDictionary;

-(void)setProjectList:(NSMutableArray *)projectList{
    if (_projectList != projectList) {
        _projectList = projectList;
        [self.tableView reloadData];
    }
}

- (IBAction)addProjectTable:(id)sender {
    
    UIAlertView *inputProjectName = [[UIAlertView alloc] initWithTitle:@"New Project" 
                                                               message:nil 
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel" 
                                                     otherButtonTitles:@"OK", nil];
    inputProjectName.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputProjectName textFieldAtIndex:0].placeholder = @"Name of Project";
    [inputProjectName textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeWords;

    [inputProjectName show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {//click done
        [self.projectList insertObject:[alertView textFieldAtIndex:0].text atIndex:0];
        [self.tableView reloadData];
    }
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.projectList = [[NSMutableArray alloc] init];
    self.projectDictionary = [[NSMutableDictionary alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.projectList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Project Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Project Cell"];
    }
    // Configure the cell...
    cell.textLabel.text = [self.projectList objectAtIndex:indexPath.row];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedProject = [self.projectList objectAtIndex:indexPath.row];
    PeopleViewController *nextController = [self.projectDictionary valueForKey:selectedProject];
    if (nextController == nil) {
        //NSLog(@"need init new PeopleViewController");
        nextController = [self.storyboard instantiateViewControllerWithIdentifier:@"PeopleViewController"];
        nextController.title = selectedProject;
        [self.projectDictionary setValue:nextController forKey:selectedProject];
    }

    [self.navigationController pushViewController:nextController animated:YES];
}

@end
