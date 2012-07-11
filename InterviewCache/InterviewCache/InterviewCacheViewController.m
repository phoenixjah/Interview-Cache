//
//  InterviewCacheViewController.m
//  InterviewCache
//
//  Created by Phx Lin. on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InterviewCacheViewController.h"
#import "ProfileView.h"
#import "MyTextInput.h"

@interface InterviewCacheViewController ()
@property (nonatomic,strong) UIScrollView *backgroundScrollView;
@end

@implementation InterviewCacheViewController
@synthesize backgroundScrollView = _backgroundScrollView;
@synthesize profile = _profile;
@synthesize insightBtn = _insightBtn, insightView = _insightView;

#pragma mark - gotoInsight
-(void)gotoInsightView:(id)sender{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [UIView transitionWithView:self.view
                      duration:2
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        [self.backgroundScrollView removeFromSuperview];
                        [self.view addSubview:self.insightView];
                    }
                    completion:NULL
     ];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    //init subviews
    self.profile = [[ProfileView alloc] initWithFrame:CGRectMake(0, 0, 640, 200)];
    self.backgroundScrollView.contentSize = CGSizeMake(500, 1000);
    self.profile.name.text = self.title;
    [self.backgroundScrollView addSubview:self.profile];
    
    MyTextInput *quote = [[MyTextInput alloc] initWithFrame:CGRectMake(0, 210, 640, 200)];
    quote.backgroundColor = [UIColor yellowColor];
    [self.backgroundScrollView addSubview:quote];
    
    MyTextInput *notes = [[MyTextInput alloc] initWithFrame:CGRectMake(0, 420, 640, 200) ];
    notes.backgroundColor = [UIColor brownColor];
    [self.backgroundScrollView addSubview:notes];
    
    self.insightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.insightBtn addTarget:self 
                        action:@selector(gotoInsightView:) 
              forControlEvents:UIControlEventTouchDown];
    [self.insightBtn setTitle:@"Insight" forState:UIControlStateNormal];
    self.insightBtn.frame = CGRectMake(0, 630, 200, 100);
    [self.backgroundScrollView addSubview:self.insightBtn];
    self.insightView = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 200, 200)];
    
    [self.view addSubview:self.backgroundScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
