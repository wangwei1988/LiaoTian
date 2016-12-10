
//  Created by Caoyq on 16/5/17.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "HCEmojiKeyboard.h"
#import "UIView+Frame.h"
#import "UIColor+MyColor.h"
#import "HCEmojiManager.h"
#import "EmojiToolBar.h"
#import "EmojiCollectionView.h"
#import "HCHeader.h"


@interface HCEmojiKeyboard ()
@property (strong, nonatomic) EmojiToolBar *emojiToolBar;
@property (strong, nonatomic) EmojiCollectionView *emojiView;

@end

@implementation HCEmojiKeyboard

#pragma mark - 初始化
+ (HCEmojiKeyboard *)sharedKeyboard {
//    static HCEmojiKeyboard *_sharedKeyboard = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _sharedKeyboard = [HCEmojiKeyboard new];
//    });
//    return _sharedKeyboard;
    //多处使用可能都要修改所以暂不使用单例初始化
    return [self new];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _showAddBtn = YES;
        self.frame = CGRectMake(0, 0, ScreenWidth, (kCollectionHeight+kPageControlHeight)+kToolBarHeight);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertEmoji:) name:@"selected" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEmojis) name:@"delete" object:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self addSubview:self.emojiView];
    [self addSubview:self.emojiToolBar];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertEmoji:) name:@"selected" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEmojis) name:@"delete" object:nil];
}

#pragma mark - lazy load

- (EmojiCollectionView *)emojiView {
    if (!_emojiView) {
        _emojiView = [EmojiCollectionView sharedCollection];
        _emojiView.center = CGPointMake(ScreenWidth/2, CGRectGetHeight(_emojiView.frame)/2);
    }
    return _emojiView;
}

- (EmojiToolBar *)emojiToolBar {
    if (!_emojiToolBar) {
        _emojiToolBar = [EmojiToolBar sharedToolBar];
        _emojiToolBar.center = CGPointMake(ScreenWidth/2, CGRectGetHeight(self.emojiView.frame)+CGRectGetHeight(_emojiToolBar.frame)/2);
        _emojiToolBar.showAddBtn = _showAddBtn;
        __weak typeof(self) weakSelf = self;
        [_emojiToolBar addBtnClicked:^{
            weakSelf.addBlock();
        }];
        [_emojiToolBar sendEmojis:^{
             weakSelf.block();
            while ([_textInput hasText]) {
                [_textInput deleteBackward];
            }
        }];
        //切换工具栏的表情
        [_emojiToolBar selectedToolBar:^(NSInteger row) {
            [_emojiView removeFromSuperview];
            _emojiView = nil;
            [self addSubview:self.emojiView];
        }];
    }
    return _emojiToolBar;
}


#pragma mark - setter

- (void)setTextInput:(id<UITextInput>)textInput {
    if ([textInput isKindOfClass:[UITextView class]]) {
        [(UITextView *)textInput setInputView:self];
    }else if ([textInput isKindOfClass:[UITextField class]]){
        [(UITextField *)textInput setInputView:self];
    }
    _textInput = textInput;
}

//zuo yong ???
//- (void)changeKeyboard{
//    [(UIControl *)_textInput resignFirstResponder];
//    [(UITextView *)_textInput setInputView:nil];
//    [(UIControl *)_textInput becomeFirstResponder];
//}

#pragma mark - 收到表情处发来的通知之后的响应
//将输入框中最后一个表情删除
- (void)deleteEmojis{
    [_textInput deleteBackward];
    [[UIDevice currentDevice] playInputClick];
    [self textChanged];
    //输入框没有文字之后，改变EmojiToolBar中sendBtn的状态
    if (![_textInput hasText]) {
        _emojiToolBar.sendBtn.enabled = NO;
        [_emojiToolBar.sendBtn setTitleColor:[UIColor sendTitleNormalColor] forState:UIControlStateNormal];
        _emojiToolBar.sendBtn.backgroundColor = [UIColor sendBgNormalColor];
    }
}

//将选中的表情插入到输入框中
- (void)insertEmoji:(NSNotification *)emoji{
    [[UIDevice currentDevice] playInputClick];
    [_textInput insertText:[emoji object]];
    [self textChanged];
    //改变EmojiToolBar中sendBtn的状态
    _emojiToolBar.sendBtn.enabled = YES;
    [_emojiToolBar.sendBtn setTitleColor:[UIColor sendTitleHighlightedColor] forState:UIControlStateNormal];
    _emojiToolBar.sendBtn.backgroundColor = [UIColor sendBgHighlightedColor];
}

#pragma mark -  通知、块-- 传递信息
//在这里发送通知，在对应页面的输入框的代码方法 textDidChange 中 执行其他操作
- (void)textChanged{
    if ([_textInput isKindOfClass:[UITextView class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:_textInput];
    else if ([_textInput isKindOfClass:[UITextField class]])
        [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidChangeNotification object:_textInput];
}

- (void)sendEmojis:(SendBlock)block {
    self.block = block;
}

- (void)addBtnClicked:(AddBlock)block {
    
    self.addBlock = block;
}

#pragma mark - UIInputViewAudioFeedback
//1、给定制的键盘添加系统键盘按键声音  2、在键盘点击处实现[[UIDevice currentDevice] playInputClick];
- (BOOL)enableInputClicksWhenVisible{
    return YES;
}

@end
