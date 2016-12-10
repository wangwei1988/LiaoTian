//
//  imageCell.m
//  聊天界面
//
//  Created by  王伟 on 2016/12/8.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "imageCell.h"
#import "UIView+Extension.h"

#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth   ScreenBounds.size.width
#define ScreenHeight  ScreenBounds.size.height
#define BtnWidth   (ScreenWidth )/ 4
@interface imageCell()

@end
@implementation imageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self addButton];
    }
    return self;
}



- (void)addButton {//CGRectMake((self.width - BtnWidth) / 2, 0, BtnWidth, self.height)
    self.button = [[imageButton alloc]initWithFrame:self.bounds];
    self.button.userInteractionEnabled = NO;
    self.button.titleLabel.font = [UIFont systemFontOfSize:14];
    self.button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button setTitle:@"照片" forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:@"jobs-1"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.button];
}



@end
