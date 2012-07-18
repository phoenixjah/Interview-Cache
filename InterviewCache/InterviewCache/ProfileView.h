//
//  ProfileView.h
//  InterviewCache
//
//  Created by Phx Lin. on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyImageInput;

@interface ProfileView : UIView
@property (nonatomic,strong) MyImageInput *portrait;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UITextField *description;
@end
