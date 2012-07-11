//
//  PeopleViewController.m
//  InterviewCache
//
//  Created by Phx Lin. on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PeopleViewController.h"
#import "InterviewCacheViewController.h"

@interface PeopleViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) NSMutableDictionary *peopleDictionary;
@end

@implementation PeopleViewController
@synthesize peopleList = _peopleList;
@synthesize peopleDictionary = _peopleDictionary;

-(void)setPeopleList:(NSMutableArray *)peopleList{
    
    if(_peopleList!=peopleList){
        _peopleList = peopleList;
        [self.tableView reloadData];
    }
}

- (IBAction)addPeopleTable:(id)sender {
    UIAlertView *inputInterviewName = [[UIAlertView alloc] initWithTitle:@"New Interview" 
                                                               message:nil 
                                                              delegate:self
                                                     cancelButtonTitle:@"Cancel" 
                                                     otherButtonTitles:@"OK", nil];
    inputInterviewName.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputInterviewName textFieldAtIndex:0].placeholder = @"Name of Interviewee";
    [inputInterviewName textFieldAtIndex:0].autocapitalizationType = UITextAutocapitalizationTypeWords;
    
    [inputInterviewName show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {//click done
        [self.peopleList insertObject:[alertView textFieldAtIndex:0].text atIndex:0];
        [self.tableView reloadData];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        InterviewCacheViewController *nextController = [[InterviewCacheViewController alloc] init];
        nextController.title = [self.peopleList objectAtIndex:0];
        [self.peopleDictionary setValue:nextController forKey:nextController.title];
        
        [self.navigationController pushViewController:nextController animated:YES];
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
    
    self.peopleList = [[NSMutableArray alloc] init];
    self.peopleDictionary = [[NSMutableDictionary alloc] init];

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
    return [self.peopleList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"People Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Project Cell"];
    }
    // Configure the cell...
    cell.textLabel.text = [self.peopleList objectAtIndex:indexPath.row];
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
    NSString *selectedPeople = [self.peopleList objectAtIndex:indexPath.row];
    InterviewCacheViewController *nextController = [self.peopleDictionary valueForKey:selectedPeople];
    if (nextController == nil) {
        //NSLog(@"need init new PeopleViewController");
        nextController = [[InterviewCacheViewController alloc] init];
        nextController.title = selectedPeople;
        [self.peopleDictionary setValue:nextController forKey:selectedPeople];
    }
    
    [self.navigationController pushViewController:nextController animated:YES];
}

@end
