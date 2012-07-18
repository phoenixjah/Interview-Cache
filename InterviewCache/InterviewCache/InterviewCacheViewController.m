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
#import <MessageUI/MessageUI.h>

#define kBorderInset            20.0
#define kBorderWidth            1.0
#define kMarginInset            10.0

//Line drawing
#define kLineWidth              1.0
@interface InterviewCacheViewController ()<UITextFieldDelegate, ImageTouchEvent,UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate>{
    CGSize pageSize;
}
@property (nonatomic,strong) UIScrollView *backgroundScrollView;
@end

@implementation InterviewCacheViewController
@synthesize backgroundScrollView = _backgroundScrollView;
@synthesize profile = _profile;
@synthesize insightBtn = _insightBtn, insightView = _insightView;

#pragma mark - gotoInsight
-(void)gotoInsightView:(id)sender{
    //viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //[self generatePDFPressed];
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
#pragma mark - Email Delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect screenRect = [self.backgroundScrollView convertRect:textField.frame toView:self.view];
    NSLog(@"%f",screenRect.origin.y);
    
    if (screenRect.origin.y > 216) {
        [self.backgroundScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y)
                                           animated:YES
         ];
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.backgroundScrollView setContentOffset:CGPointMake(0, textField.frame.origin.y - 20) animated:YES
     ];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
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
    self.backgroundScrollView.contentSize = CGSizeMake(320, 1200);
    self.profile.name.text = self.title;
    self.profile.description.delegate = self;
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
    
    UIButton *sendPDF = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendPDF addTarget:self action:@selector(generatePDFPressed) forControlEvents:UIControlEventTouchDown];
    sendPDF.frame = CGRectMake(0, 950, 320, 50);
    [self.backgroundScrollView addSubview:sendPDF];
    [self.view addSubview:self.backgroundScrollView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - Generate PDF
-(void)generatePDFPressed{
    pageSize = CGSizeMake(612, 792);
    NSString *fileName = @"Test.pdf";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pdfFileName = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [self generatePdfWithFilePath:pdfFileName];
}

-(void)generatePdfWithFilePath:(NSString*)filePath{
    UIGraphicsBeginPDFContextToFile(filePath, CGRectZero, nil);
    //NSLog(@"size %f",pageSize.width);
    NSInteger currentPage = 0;
    BOOL done = NO;
  
    do
    {
        // Mark the beginning of a new page.
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, pageSize.width, pageSize.height), nil);
        
        // Draw a page number at the bottom of each page.
        currentPage++;
        //[self drawPageNumber:currentPage];
        
        //Draw a border for each page.
        [self drawBorder];
        
        //Draw text fo our header.
        //[self drawHeader];
        
        //Draw a line below the header.
        [self drawLine];
        
        //Draw some text for the page.
        [self drawText];
        
        //Draw an image
        [self drawImage];
        done = YES;
    }
    while (!done);
   
    // Close the PDF context and write the contents out.
    UIGraphicsEndPDFContext();
    [self sendPDFWithFilePath:filePath];
}

- (void) drawBorder{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    UIColor *borderColor = [UIColor brownColor];
    CGRect rectFrame = CGRectMake(kBorderInset, kBorderInset, pageSize.width-kBorderInset*2, pageSize.height-kBorderInset*2);
    CGContextSetStrokeColorWithColor(currentContext, borderColor.CGColor);
    CGContextSetLineWidth(currentContext, kBorderWidth);
    CGContextStrokeRect(currentContext, rectFrame);
}

- (void) drawLine{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(currentContext, kLineWidth);
    
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blueColor].CGColor);
    
    CGPoint startPoint = CGPointMake(kMarginInset + kBorderInset, kMarginInset + kBorderInset + 40.0);
    CGPoint endPoint = CGPointMake(pageSize.width - 2*kMarginInset -2*kBorderInset, kMarginInset + kBorderInset + 40.0);
    
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
    
    CGContextClosePath(currentContext);
    CGContextDrawPath(currentContext, kCGPathFillStroke);
}

- (void) drawText{
    CGContextRef    currentContext = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(currentContext, 0.0, 0.0, 0.0, 1.0);
    
    NSString *textToDraw = self.profile.name.text;
    
    UIFont *font = [UIFont systemFontOfSize:14.0];
    
    CGSize stringSize = [textToDraw sizeWithFont:font
                               constrainedToSize:CGSizeMake(pageSize.width - 2*kBorderInset-2*kMarginInset, pageSize.height - 2*kBorderInset - 2*kMarginInset)
                                   lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect renderingRect = CGRectMake(kBorderInset + kMarginInset, kBorderInset + kMarginInset + 50.0, pageSize.width - 2*kBorderInset - 2*kMarginInset, stringSize.height);
    
    [textToDraw drawInRect:renderingRect
                  withFont:font
             lineBreakMode:UILineBreakModeWordWrap
                 alignment:UITextAlignmentLeft];
}

- (void) drawImage{
    UIImage *demoImage = self.profile.portrait.image;
    [demoImage drawInRect:CGRectMake( (pageSize.width - demoImage.size.width/2)/2, 350, demoImage.size.width/2, demoImage.size.height/2)];
}

-(void)sendPDFWithFilePath:(NSString*)path{    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    NSString *content = @"Interview sharing";
    [picker setSubject:content];
    
    
    //ATTACH FILE

    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]){//Does file exist?
        //NSLog(@"in NewCardSorting sendResult File exists to attach");
        
        NSData *myData = [NSData dataWithContentsOfFile:path];
        
        [picker addAttachmentData:myData mimeType:@"application/pdf"
                         fileName:@"Arthur"];
        
    }
    
    //CREATE EMAIL BODY TEXT
    
    content = @"Interview at Date:";
    [picker setMessageBody:content isHTML:NO];
    picker.modalPresentationStyle = UIModalPresentationPageSheet;
    
    //PRESENT THE MAIL COMPOSITION INTERFACE
    [self presentViewController:picker animated:YES completion:nil];
}
@end
