
//  Created by Caoyq on 16/5/17.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmojiToolBar.h"

typedef void(^SendBlock)(void);
typedef void(^AddBlock)(void);

@interface HCEmojiKeyboard : UIView<UIInputViewAudioFeedback>

#pragma mark - -----Properties-----

@property (strong, nonatomic) id<UITextInput> textInput;
@property (strong, nonatomic) SendBlock block;
@property (strong, nonatomic) AddBlock addBlock;

/**
 * 是否需要显示添加按钮
 * @param  param    如果需要显示，那么附带的点击回传方法必须实现
 * @param  param   Default is YES
 */
@property (assign, nonatomic) BOOL showAddBtn;

#pragma mark - -----Methods-----

/**
 *初始化一个 HCEmojiKeyboard 对象
 *@param   初始化的对象    宽高一定，不可修改
 */
+ (HCEmojiKeyboard *)sharedKeyboard;

/**
 *点击了发送
 */
- (void)sendEmojis:(SendBlock)block;

- (void)addBtnClicked:(AddBlock)block;

@end
