
//  Created by Caoyq on 16/5/10.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "HCInputBar.h"
#import "HCHeader.h"
#import "ExpandingCell.h"
#import "FunctionsView.h"
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth   ScreenBounds.size.width
#define ScreenHeight  ScreenBounds.size.height
#define cellWidth (ScreenWidth )/ 4
#define cellHeight (ScreenWidth )/ 4
@interface HCInputBar ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UITextView *inputView;
@property (strong, nonatomic) UICollectionView *expandingView;
@property (strong, nonatomic) UIButton *keyboardTypeBtn;
@property (assign, nonatomic) InputBarStyle style;

@property (strong, nonatomic) NSMutableArray *imgAry;
@property (strong, nonatomic) NSMutableArray *selectedImgAry;
@property (assign, nonatomic) NSInteger PreSelectedRow;
@property (assign, nonatomic) NSInteger selectedRow;

/**< textView的placeHodle */
@property (strong, nonatomic) UILabel *placeHolderLabel;


@property (strong, nonatomic) UIButton *addBtn;
@property (strong, nonatomic) FunctionsView *funcsView;
@end
@implementation HCInputBar

- (instancetype)initWithStyle:(InputBarStyle)style {
    _style = style;
    CGFloat height;
    if (_style == ExpandingInputBarStyle) {
        height = kInputBarHeight+kExpandingHeight;
    }else{
        height = kInputBarHeight;
    }
    self = [super initWithFrame:CGRectMake(0, ScreenHeight-height, ScreenWidth, height)];
    self.backgroundColor = [UIColor backgroundColor];
    self.layer.borderColor = [[UIColor bigBorderColor] CGColor];
    self.layer.borderWidth = 0.5;

    if (self) {
        _keyboard = [HCEmojiKeyboard sharedKeyboard];
        [_keyboard sendEmojis:^{
            [self didClickSendEmojis];
        }];
        [self addSubview:self.inputView];
        [self addSubview:self.placeHolderLabel];
        [self addSubview:self.addBtn];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.masksToBounds = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    _PreSelectedRow = kPreSelectedRow;
    _selectedRow = kSelectedRow;
    [self getImgData];
    if (_style == ExpandingInputBarStyle) {
        [self addSubview:self.expandingView];
    }else{
        [self addSubview:self.keyboardTypeBtn];
    }
}

#pragma mark - load
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.inputView.frame) + kKeyboardX, kKeyboardY, kKeyboardWidth, kKeyboardWidth)];
        _addBtn.tag = 2;
        [_addBtn setImage:ImgName(add) forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(ClickedKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)keyboardTypeBtn {
    if (!_keyboardTypeBtn) {
        _keyboardTypeBtn = [[UIButton alloc]initWithFrame:CGRectMake(kKeyboardX, kKeyboardY, kKeyboardWidth, kKeyboardWidth)];
        _keyboardTypeBtn.tag = 0;
        [_keyboardTypeBtn setImage:ImgName(emoji) forState:UIControlStateNormal];
        [_keyboardTypeBtn addTarget:self action:@selector(ClickedKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyboardTypeBtn;
}

- (UITextView *)inputView {
    if (!_inputView) {
        if (_style == ExpandingInputBarStyle) {
            _inputView = [[UITextView alloc]initWithFrame:CGRectMake(kInputViewOtherX, kInputViewY, kInputViewOtherWidth, kInputViewHeight)];
        }else{
            _inputView = [[UITextView alloc]initWithFrame:CGRectMake(kInputViewX, kInputViewY, kInputViewWidth - kKeyboardWidth - 2*kKeyboardX, kInputViewHeight)];
        }
        _inputView.returnKeyType = UIReturnKeySend;
        _inputView.showsVerticalScrollIndicator = NO;
        _inputView.scrollEnabled = NO;
        _inputView.delegate = self;
        _inputView.font = [UIFont inputViewFont];
        _inputView.backgroundColor = [UIColor whiteColor];
        _inputView.tintColor = [UIColor clearColor];
        [self setBorderinView:_inputView CornerRadius:7 Color:[UIColor borderColor]];
    }
    return _inputView;
}

- (FunctionsView *)funcsView {
    if (!_funcsView) {
        _funcsView = [[FunctionsView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, cellWidth * 2)];
        _funcsView.chooseImg = ^{
            NSLog(@"选择相片");
            if (self.chooseImages) {
                self.chooseImages();
            }
        };
    }
    return _funcsView;
}

- (UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        if (_style == ExpandingInputBarStyle) {
            _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(kInputViewOtherX+kKeyboardX, kInputViewY, kInputViewOtherWidth-kKeyboardX, kInputViewHeight)];
        }else{
            _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(kInputViewX+kKeyboardX, kInputViewY, kInputViewWidth-kKeyboardX , kInputViewHeight)];
        }
        _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
        _placeHolderLabel.font = [UIFont inputViewFont];
        _placeHolderLabel.minimumScaleFactor = 0.9;
        _placeHolderLabel.textColor = [UIColor sendTitleNormalColor];
        _placeHolderLabel.userInteractionEnabled = NO;
        _placeHolderLabel.text = _placeHolder;
    }
    return _placeHolderLabel;
}

- (UICollectionView *)expandingView {
    if (!_expandingView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat space = (ScreenWidth-self.imgAry.count*kItemSize)/(self.imgAry.count+1)-0.01;
        [layout setItemSize:CGSizeMake(kItemSize, kItemSize)];
        layout.minimumInteritemSpacing = space;
        [layout setSectionInset:UIEdgeInsetsMake(kTopSpace, space, kBottomSpace, space)];
        _expandingView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kInputBarHeight, ScreenWidth, kExpandingHeight) collectionViewLayout:layout];
        _expandingView.delegate = self;
        _expandingView.dataSource = self;
        _expandingView.backgroundColor = [UIColor backgroundColor];
        [_expandingView registerClass:[ExpandingCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _expandingView;
}

- (void)getImgData {
    if (!_expandingAry || _expandingAry.count == 0) {
        _imgAry = [NSMutableArray arrayWithObjects:voice,video,photo,camera,emoji, nil];
        _selectedImgAry = [NSMutableArray arrayWithObjects:selectedVoice,selectedVideo,selectedPhoto,selectedCamera,selectedEmoji, nil];
    }else{
        _imgAry = [NSMutableArray new];
        _selectedImgAry = [NSMutableArray new];
        for (NSNumber *number in _expandingAry){
            NSInteger img = [number integerValue];
            NSString *showImg = [NSString new];
            NSString *selectedImg = [NSString new];
            switch (img) {
                case ImgStyleWithVoice:{
                    showImg = voice;
                    selectedImg = selectedVoice;
                }
                    break;
                case ImgStyleWithVideo:{
                    showImg = video;
                    selectedImg = selectedVideo;
                }
                    break;
                case ImgStyleWithPhoto:{
                    showImg = photo;
                    selectedImg = selectedPhoto;
                }
                    break;
                case ImgStyleWithCamera:{
                    showImg = camera;
                    selectedImg = selectedCamera;
                }
                    break;
                case ImgStyleWithEmoji:{
                    showImg = emoji;
                    selectedImg = selectedEmoji;
                }
                    break;
                default:
                    break;
            }
            [_imgAry addObject:showImg];
            [_selectedImgAry addObject:selectedImg];
        }
    }
}

#pragma mark - Set 方法
//接口处.placeHolder 会调用set方法
- (void)setPlaceHolder:(NSString *)placeHolder {
    self.placeHolderLabel.text = placeHolder;
}

#pragma mark - click
- (void)ClickedKeyboard:(UIButton *)btn {
    if (btn.tag == 0) {
        [_keyboard setTextInput:_inputView];
        [btn setImage:ImgName(keyboard) forState:UIControlStateNormal];
    } else if (btn.tag == 2) {
//        [_keyboard setTextInput:self.funcsView];
        [_inputView setInputView:self.funcsView];
        [_keyboardTypeBtn setImage:ImgName(keyboard) forState:UIControlStateNormal];
    }
    else{
        _inputView.inputView = nil;
        [btn setImage:ImgName(emoji) forState:UIControlStateNormal];
    }
    [_inputView reloadInputViews];
    if (btn.tag == 2) {
        _keyboardTypeBtn.tag = 1;
    } else {
        btn.tag = btn.tag == 0 ? 1 : 0;
    }
    [_inputView becomeFirstResponder];
}

- (void)didClickSendEmojis {
    if (self.block) {
        self.block(_inputView.text);
    }
    _inputView.text = @"";
    [self layout];
}

#pragma mark - set border
- (void)setBorderinView:(UIView *)view CornerRadius:(CGFloat)f Color:(UIColor *)color{
    view.layer.borderColor = [color CGColor];
    view.layer.borderWidth = 0.8;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = f;
}

#pragma mark - 随着文字增多，改变布局
- (void)layout {
    
    _placeHolderLabel.hidden = _inputView.text.length > 0 ? YES : NO;
    
    CGSize textSize = [_inputView sizeThatFits:CGSizeMake(CGRectGetWidth(_inputView.frame), MAXFLOAT)];
    CGFloat offset = 10;
    _inputView.scrollEnabled = (textSize.height > kInputViewMaxHeight - offset);
    [_inputView setHeight:MAX(kInputViewHeight, MIN(kInputViewMaxHeight, textSize.height))];
    
    [_expandingView setY:CGRectGetHeight(_inputView.frame)+CGRectGetMinY(_inputView.frame)*2];
    
    //此时的self.frame.origin.y已经改变了，因为键盘升起
    CGFloat maxY = CGRectGetMaxY(self.frame);
    [self setHeight:CGRectGetHeight(_inputView.frame)+CGRectGetMinY(_inputView.frame)*2+CGRectGetHeight(_expandingView.frame)];
    [self setY:maxY - CGRectGetHeight(self.frame)];
    
    _keyboardTypeBtn.center = CGPointMake(CGRectGetMidX(_keyboardTypeBtn.frame), CGRectGetHeight(self.frame)/2);
}

#pragma mark - 块方法

- (void)showInputViewContents:(InputViewContents)string {
    self.block = string;
}

#pragma mark - 收到通知、监控键盘

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         CGRect newInputViewFrame = self.frame;
                         newInputViewFrame.origin.y = [UIScreen mainScreen].bounds.size.height-CGRectGetHeight(self.frame)-kbSize.height;
                         self.frame = newInputViewFrame;
                     }
                     completion:nil];
}

- (void)keyboardWillHidden:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:[info[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0
                        options:([info[UIKeyboardAnimationCurveUserInfoKey] integerValue]<<16)
                     animations:^{
                         self.center = CGPointMake(self.bounds.size.width/2.0f, height-CGRectGetHeight(self.frame)/2.0);
                     }
                     completion:nil];
}

#pragma mark - UITextView Delegate
- (void)textViewDidChange:(UITextView *)textView {
    [self layout];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        //点击系统键盘上的发送
        [self didClickSendEmojis];
        return NO;
    }
    return YES;
}


#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imgAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExpandingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.imgView.image = ImgName(_imgAry[indexPath.row]);
    return cell;
}

#pragma mark - UICollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //对上一个选择的cell作处理
    if (_PreSelectedRow != indexPath.row && _PreSelectedRow != kPreSelectedRow) {
        NSIndexPath *preIndexPath = [NSIndexPath indexPathForRow:_PreSelectedRow inSection:0];
        ExpandingCell *cell = (ExpandingCell *)[_expandingView cellForItemAtIndexPath:preIndexPath];
        cell.imgView.image = ImgName(_imgAry[_PreSelectedRow]);
    }
    //对当前选中cell作处理
    ExpandingCell *cell = (ExpandingCell *)[_expandingView cellForItemAtIndexPath:indexPath];
    if (_selectedRow != indexPath.row) {
        _selectedRow = indexPath.row;
        cell.imgView.image = ImgName(_selectedImgAry[indexPath.row]);
    }else{
        _selectedRow = kSelectedRow;
        cell.imgView.image = ImgName(_imgAry[indexPath.row]);
    }

    //选中对应cell，确定做的事
    if ([_imgAry[indexPath.row] isEqualToString:voice]) {
        NSLog(@"语音处理");
        [self handleVoice:_selectedRow];
    }else if ([_imgAry[indexPath.row] isEqualToString:video]){
        NSLog(@"视频处理");
    }else if ([_imgAry[indexPath.row] isEqualToString:photo]){
        NSLog(@"照片处理");
    }else if ([_imgAry[indexPath.row] isEqualToString:camera]){
        NSLog(@"相机处理");
    }else if ([_imgAry[indexPath.row] isEqualToString:emoji]){
        NSLog(@"表情处理");
        [self handleEmoji:_selectedRow];
    }
    
    //
    _PreSelectedRow = indexPath.row;
    
}

#pragma mark - cell点击之后的处理事件
- (void)handleVoice:(NSInteger)selected {
    if (selected == kSelectedRow) {
        //取消

    }else{
        //开启
    
    }
}

- (void)handleVideo:(NSInteger)selected {
    if (selected == kSelectedRow) {
        //取消
        
    }else{
        //开启
        
    }
}

- (void)handlePhoto:(NSInteger)selected {
    if (selected == kSelectedRow) {
        //取消
        
    }else{
        //开启
        
    }
}

- (void)handleCamera:(NSInteger)selected {
    if (selected == kSelectedRow) {
        //取消
        
    }else{
        //开启
        
    }
}

- (void)handleEmoji:(NSInteger)selected {
    if (selected == kSelectedRow) {
        //取消
        _inputView.inputView = nil;
    }else{
        //开启
        [_keyboard setTextInput:_inputView];
    }
    [_inputView reloadInputViews];
    [_inputView becomeFirstResponder];
}

@end
