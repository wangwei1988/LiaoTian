//
//  showImgView.m
//  聊天界面
//
//  Created by  王伟 on 2016/12/12.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "showImgView.h"
#import "UIView+Extension.h"
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth   ScreenBounds.size.width
#define ScreenHeight  ScreenBounds.size.height
@interface showImgView ()
@property (nonatomic , strong) UIImageView *imageView;
@end

@implementation showImgView

+(instancetype)initWithImg:(UIImage *)image {
    showImgView *showV = [[showImgView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    showV.backgroundColor = [UIColor blackColor];
    showV.imageView = [UIImageView new];
    showV.imageView.frame = CGRectMake(0, (ScreenHeight - image.size.height / image.size.width * ScreenWidth) / 2, ScreenWidth, image.size.height / image.size.width * ScreenWidth);
    showV.imageView.userInteractionEnabled = NO;
    [showV.imageView setImage:image];
    [showV addSubview:showV.imageView];
    return showV;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    /*  动画效果😁后面在做
    [UIView animateWithDuration:1.0 animations:^{
        self.imageView.x = (ScreenWidth - 10) / 2;
        self.imageView.y = (ScreenHeight - 10) / 2;
        self.imageView.width = 10;
        self.imageView.height = 10;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
     */
    
}


@end
