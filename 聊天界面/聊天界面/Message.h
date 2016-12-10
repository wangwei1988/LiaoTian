//
//  AppDelegate.h
//  聊天界面
//
//  Created by  王伟 on 2016/12/4.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Message : NSObject

@property (nonatomic,strong)NSString *content;

@property (nonatomic,strong)UIImage *image;

@property (nonatomic,assign)BOOL isRight;

@property (nonatomic,assign) NSInteger Height;

@property (nonatomic,assign) CGRect contentframe;

@property (nonatomic,assign) CGRect popframe;

@property (nonatomic,assign) CGRect bounds;

@property (nonatomic,assign) CGRect headerFrame;

@property (nonatomic,assign) CGRect imageFrame;

//构造消息对象 -- 消息文本
+ (instancetype) messageWihtContent:(NSString *)content isRight:(BOOL)isRight;

//构造消息对象 -- 消息图片
+ (instancetype) messageWihtImage:(UIImage *)image isRight:(BOOL)isRight;

@end
