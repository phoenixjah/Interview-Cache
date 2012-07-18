//
//  MyTextInput.h
//  InterviewCache
//
//  Created by Phx Lin. on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTextInput : UITextField
@property (nonatomic,weak) UIImageView *backgroundImage;
-(void)setBackground:(NSString*)imageName;
@end
