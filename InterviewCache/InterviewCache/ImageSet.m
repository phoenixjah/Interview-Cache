//
//  ImageSet.m
//  InterviewCache
//
//  Created by Chia Lin on 12/7/12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageSet.h"
#import "MyImageInput.h"

@implementation ImageSet
@synthesize title = _title, description = _description, images = _images;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor lightGrayColor];
        self.title = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 20)];
        self.title.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        
        UIImageView *imageEx = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
        imageEx.backgroundColor = [UIColor blueColor];
        [self addSubview:imageEx];
        self.description = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 20) ];
        self.description.backgroundColor = [UIColor whiteColor];
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
