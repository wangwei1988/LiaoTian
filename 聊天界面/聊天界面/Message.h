//
//  Message.h
//  融云测试
//
//  Created by  王伟 on 2016/12/3.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Message : NSObject

@property (nonatomic,strong)NSString *content;

@property (nonatomic,assign)BOOL isRight;

@property (nonatomic,assign) NSInteger Height;

@property (nonatomic,assign) CGRect contentframe;

@property (nonatomic,assign) CGRect popframe;

@property (nonatomic,assign) CGRect bounds;

@property (nonatomic,assign) CGRect headerFrame;
//构造消息对象
+ (instancetype) messageWihtContent:(NSString *)content isRight:(BOOL)isRight;

@end
