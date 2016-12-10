
//  Created by Caoyq on 16/5/11.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "ExpandingCell.h"

@implementation ExpandingCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgView];
    }
    return self;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:self.bounds];
    }
    return _imgView;
}

@end
