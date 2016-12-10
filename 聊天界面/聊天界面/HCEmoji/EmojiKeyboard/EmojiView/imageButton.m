//
//  imageButton.m
//  聊天界面
//
//  Created by  王伟 on 2016/12/8.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "imageButton.h"
#import "UIView+Extension.h"
@implementation imageButton

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.x = (self.width - 48) / 2;
    self.imageView.size = CGSizeMake(48, 48);
    self.titleLabel.x = 0 ;
    self.titleLabel.size = CGSizeMake(self.width, 12);
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 5;
    self.titleLabel.width = self.width;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self layoutSubviews];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self layoutSubviews];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
    [self layoutSubviews];
}
@end
