
//  Created by Caoyq on 16/5/13.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "EmojiCell.h"

@implementation EmojiCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.lab];
        [self addSubview:self.img];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIButton *)lab {
    if (!_lab) {
        _lab = [[UIButton alloc]initWithFrame:self.bounds];
        _lab.titleLabel.textAlignment = NSTextAlignmentCenter;
        _lab.enabled = NO;
        _lab.titleLabel.font = [UIFont systemFontOfSize:28];
    }
    return _lab;
}

- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(2, 2, self.bounds.size.width-4, self.bounds.size.height-4)];
        [_img setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _img;
}

@end
