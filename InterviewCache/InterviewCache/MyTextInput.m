//
//  MyTextInput.m
//  InterviewCache
//
//  Created by Phx Lin. on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTextInput.h"

@implementation MyTextInput
@synthesize backgroundImage = _backgroundImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundImage = [[UIImageView alloc] initWithFrame:frame];
        self.textAlignment = UITextAlignmentCenter;
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.text) {
        NSLog(@"have text");
        [self resignFirstResponder];
    }
}

-(void)setBackground:(NSString *)imageName{
    self.backgroundImage.image = [UIImage imageNamed:imageName];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
