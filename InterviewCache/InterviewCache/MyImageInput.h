//
//  MyImageInput.h
//  InterviewCache
//
//  Created by Phx Lin. on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageTouchEvent
-(void)pickImage:(UIImageView*)atHere;
@end
@interface MyImageInput : UIImageView
@property (nonatomic, weak) id <ImageTouchEvent> message;
@end
