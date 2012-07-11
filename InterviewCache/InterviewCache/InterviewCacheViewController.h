//
//  InterviewCacheViewController.h
//  InterviewCache
//
//  Created by Phx Lin. on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileView;
@interface InterviewCacheViewController : UIViewController
@property (nonatomic,strong) ProfileView *profile;
@property (nonatomic,strong) UIButton *insightBtn;
@property (nonatomic,strong) UITextView *insightView;

@end
