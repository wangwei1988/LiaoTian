
//  Created by Caoyq on 16/5/10.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCEmojiKeyboard.h"

typedef NS_ENUM(NSInteger, InputBarStyle) {
    DefaultInputBarStyle, /**<默认类型：键盘按钮和表情按钮一体，没有拓展界面*/
    ExpandingInputBarStyle /**<拓展类型：没有键盘按钮，表情按钮和其他按钮集成在拓展界面*/
};

typedef NS_ENUM(NSInteger, ImgStyle) {
    ImgStyleWithVideo, /**< 视频 */
    ImgStyleWithVoice, /**< 语音 */
    ImgStyleWithPhoto, /**< 图片 */
    ImgStyleWithCamera, /**< 相机 */
    ImgStyleWithEmoji   /**< 表情 */
};

typedef void(^InputViewContents)(NSString *contents);
typedef void (^chooseImages)();
@interface HCInputBar : UIView

#pragma mark - -----Properties-----
@property (strong, nonatomic) HCEmojiKeyboard *keyboard;
@property (strong, nonatomic) InputViewContents block;
@property (strong, nonatomic) chooseImages chooseImages;
/**
 *textView的背景文字，不设置则默认不存在
 */
@property (strong, nonatomic) NSString *placeHolder;

/**
 *自定义拓展栏选项的排列顺序及个数，该数组存储的是ImgStyle结构体中的成员，
 *@param  ImgStyle类型有:  ImgStyleWithVoice，ImgStyleWithVideo，ImgStyleWithPhoto，ImgStyleWithCamera，ImgStyleWithEmoji
 *@param  存储格式： 如[NSNumber numberWithInteger:ImgStyleWithVideo]
 */
@property (strong, nonatomic) NSArray *expandingAry;

#pragma mark - -----Methods-----
/**
 *初始化HCInputBar的方法
 *@param   style   选择的类型：有默认类型和拓展类型
 */
- (instancetype)initWithStyle:(InputBarStyle)style;

/**
 *获取输入框中的文字或表情
 */
- (void)showInputViewContents:(InputViewContents)string;

@end
