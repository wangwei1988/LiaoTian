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
@property (nonatomic , assign) CGRect imgOriginFram;
@property (nonatomic , assign) CGFloat maxAndmin;
@property (nonatomic , assign) BOOL isFirstTap;
@end

@implementation showImgView

+(instancetype)initWithImg:(UIImage *)image withFame:(CGRect)frame{
    showImgView *showV = [[showImgView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    showV.maxAndmin = 2.0;
    showV.backgroundColor = [UIColor clearColor];
    showV.imgOriginFram = frame;
    showV.imageView = [UIImageView new];
    showV.imageView.frame = frame;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            showV.imageView.frame = CGRectMake(0, (ScreenHeight - image.size.height / image.size.width * ScreenWidth) / 2, ScreenWidth, image.size.height / image.size.width * ScreenWidth);
        } completion:^(BOOL finished) {
            showV.backgroundColor = [UIColor blackColor];
        }];
    });
    showV.imageView.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]initWithTarget:showV action:@selector(pinch:)];
    [showV.imageView addGestureRecognizer:pinchRecognizer];
    
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc]initWithTarget:showV action:@selector(tap:)];
    tapRecognizer1.numberOfTapsRequired = 1;
    tapRecognizer1.numberOfTouchesRequired = 1;
    [showV.imageView addGestureRecognizer:tapRecognizer1];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:showV action:@selector(tap:)];
    tapRecognizer.numberOfTapsRequired = 2;
    tapRecognizer.numberOfTouchesRequired = 1;
    [showV.imageView addGestureRecognizer:tapRecognizer];
    
    [tapRecognizer1 requireGestureRecognizerToFail:tapRecognizer];
    
    [showV.imageView setImage:image];
    [showV addSubview:showV.imageView];
    return showV;
}



-(void)pinch:(UIPinchGestureRecognizer*)gr{
    CGFloat scale = gr.scale;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    CGAffineTransform transForm;
    if (scale > 1.0) {
        if (self.maxAndmin > 10.0) {
            return ;
        }
        transForm  = CGAffineTransformScale(self.imageView.transform, 1.01, 1.01);
        self.maxAndmin = self.maxAndmin + 0.2;
    } else {
        if (self.maxAndmin <= 0.0) {
            return;
        }
        transForm = CGAffineTransformScale(self.imageView.transform, 1/1.01, 1/1.01);
        self.maxAndmin = self.maxAndmin - 0.2;
    }
    NSLog(@"%f",self.maxAndmin);
    [self.imageView setTransform:transForm];
    [UIView commitAnimations];

}

- (void)tap:(UITapGestureRecognizer*)gr {
    
    if (gr.numberOfTapsRequired == 1) {
        self.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.5 animations:^{
            self.imageView.frame = self.imgOriginFram;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];

    } else {
        self.isFirstTap = !self.isFirstTap ;
        if (self.isFirstTap) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            CGAffineTransform transForm;
            transForm  = CGAffineTransformScale(self.imageView.transform, pow(1.01, 40), pow(1.01, 40));
            self.maxAndmin = 10.0;
            [self.imageView setTransform:transForm];
            [UIView commitAnimations];
        } else {
            self.maxAndmin = 2.0;
            self.imageView.transform = CGAffineTransformIdentity;
        }
    }
}




@end
