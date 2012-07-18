//
//  ProfileView.m
//  InterviewCache
//
//  Created by Phx Lin. on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileView.h"
#import "MyImageInput.h"

@implementation ProfileView
@synthesize portrait, name, description;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.portrait = [[MyImageInput alloc] initWithFrame:CGRectMake(10, 10, 180, 180)];
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(200, 10, 100, 50)];
        self.description = [[UITextField alloc] initWithFrame:CGRectMake(200, 80, 100, 80)];
        self.backgroundColor = [UIColor whiteColor];
        self.portrait.backgroundColor = [UIColor grayColor];
        self.name.backgroundColor = [UIColor yellowColor];
        self.description.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.portrait];
        [self addSubview:self.name];
        [self addSubview:self.description];
    }
    return self;
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
