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
#import "MyImageInput.h"
#import "ImageSet.h"


@interface InterviewCacheViewController ()<UITextViewDelegate, ImageTouchEvent,UIImagePickerControllerDelegate>
@property (nonatomic,strong) UIScrollView *backgroundScrollView;
@end

@implementation InterviewCacheViewController
@synthesize backgroundScrollView = _backgroundScrollView;
@synthesize profile = _profile;
@synthesize insightBtn = _insightBtn, insightView = _insightView;

#pragma mark - gotoInsight
-(void)gotoInsightView:(id)sender{
    //viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [UIView transitionWithView:self.view
                      duration:1 
                       options:UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        [self.backgroundScrollView removeFromSuperview];
                        [self.view addSubview:self.insightView];
                    }
                    completion:^(BOOL finished){
                        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                        [backBtn setTitle:@"Back" forState:UIControlStateNormal];
                        backBtn.frame = CGRectMake(240, 20, 80, 50);
                        [backBtn addTarget:self
                                    action:@selector(backInsightView:)
                          forControlEvents:UIControlEventTouchDown
                         ];
                        [self.insightView addSubview:backBtn];
                        self.navigationItem.hidesBackButton = YES;
                    }
     ];
    
}
-(void)backInsightView:(id)sender{
    [UIView transitionWithView:self.view
                      duration:1 
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.insightView removeFromSuperview];
                        [self.view addSubview:self.backgroundScrollView];
                    }
                    completion:^(BOOL finished){
                        self.navigationItem.hidesBackButton = NO;
                    }
     ];

}
#pragma mark - UITextView Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    //NSLog(@"Keyboard Appear?");
    [self.backgroundScrollView setContentOffset:CGPointMake(0, textView.frame.origin.y) 
                                       animated:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    //NSLog(@"Keyboard Disappear?");
    [self.backgroundScrollView setContentOffset:CGPointMake(0, textView.frame.origin.y - 100) 
                                       animated:YES];

}
#pragma mark - ImageTouchEvent Delegate
-(void)pickImage:(UIImageView *)atHere{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    [self presentModalViewController:imagePicker animated:YES];
    
}
#pragma mark - UIImagePikerController Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    self.profile.portrait.image = image;
    [self dismissModalViewControllerAnimated:YES];
}
#pragma mark - ViewController LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    //init subviews
    self.profile = [[ProfileView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    self.backgroundScrollView.contentSize = CGSizeMake(320, 1000);
    self.profile.name.text = self.title;
    self.profile.portrait.message = self;
    [self.backgroundScrollView addSubview:self.profile];
    
    MyTextInput *quote = [[MyTextInput alloc] initWithFrame:CGRectMake(0, 210, 320, 200)];
    quote.backgroundColor = [UIColor yellowColor];
    quote.delegate = self;
    [self.backgroundScrollView addSubview:quote];
    
    MyTextInput *notes = [[MyTextInput alloc] initWithFrame:CGRectMake(0, 420, 320, 200) ];
    notes.backgroundColor = [UIColor brownColor];
    notes.delegate = self;
    [self.backgroundScrollView addSubview:notes];
    
    self.insightBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.insightBtn addTarget:self 
                        action:@selector(gotoInsightView:) 
              forControlEvents:UIControlEventTouchDown];
    [self.insightBtn setTitle:@"Insight" forState:UIControlStateNormal];
    self.insightBtn.frame = CGRectMake(0, 830, 320, 100);
    [self.backgroundScrollView addSubview:self.insightBtn];
    self.insightView = [[MyTextInput alloc] initWithFrame:CGRectMake(0, 44, 320, 200)];
    self.insightView.delegate = self;
    
    ImageSet *imageSet = [[ImageSet alloc] initWithFrame:CGRectMake(0, 630, 320, 200)];
    [self.backgroundScrollView addSubview:imageSet];
    
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
