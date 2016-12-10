
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#ifndef HCHeader_h
#define HCHeader_h

#import "UIFont+MyFont.h"
#import "UIView+Frame.h"
#import "UIColor+MyColor.h"


#pragma mark - -----HCInputBar-----
static NSString *add     = @"Resources.bundle/+";
static NSString *emoji     = @"Resources.bundle/emoji";
static NSString *keyboard  = @"Resources.bundle/keyboard";
static NSString *camera    = @"Resources.bundle/camera";
static NSString *photo     = @"Resources.bundle/photo";
static NSString *video     = @"Resources.bundle/video";
static NSString *voice     = @"Resources.bundle/voice";

static NSString *selectedEmoji  = @"Resources.bundle/emojiHighlighted";
static NSString *selectedVoice  = @"Resources.bundle/voiceHighlighted";
static NSString *selectedVideo  = @"Resources.bundle/videoHighlighted";
static NSString *selectedPhoto  = @"Resources.bundle/photoHighlighted";
static NSString *selectedCamera = @"Resources.bundle/cameraHighlighted";

#define kInputBarHeight     50

#define kKeyboardX          4
#define kKeyboardY          (kInputBarHeight-kKeyboardWidth)/2
#define kKeyboardWidth      28

#define kInputViewX         (kKeyboardWidth+kKeyboardX*2)
#define kInputViewY         7
#define kInputViewWidth     (ScreenWidth-kInputViewX-kKeyboardX)
#define kInputViewHeight    (kInputBarHeight-kInputViewY*2)
#define kInputViewMaxHeight 60
//ExpandingType下的坐标
#define kInputViewOtherX    kKeyboardX
#define kInputViewOtherWidth    (ScreenWidth-kInputViewOtherX*2)

#define kExpandingHeight    40
#define kTopSpace           4
#define kBottomSpace        10
#define kItemSize           (kExpandingHeight-kTopSpace-kBottomSpace)

#define kPreSelectedRow     10000
#define kSelectedRow        20000

#pragma mark - -----EmojiCollectionView-----

#define kCollectionHeight   (kIconSize*3+kIconTop*4)
#define kPageControlHeight  20

#define kPageCount          20.0


#pragma mark - -----SinglePageEmojiCell-----

#define kIconSize    32
#define kIconTop     17
#define kIconLeft    (ScreenWidth -kIconSize*7)/8

static NSString *delete = @"Resources.bundle/delete";

#pragma mark - -----EmojiToolBar-----

#define kToolBarHeight      40
#define kSendBtnWidth       50

static NSString *toolBarEmoji = @"Resources.bundle/toolBarEmoji";
static NSString *toolBarLoving = @"Resources.bundle/toolBarLoving";

#pragma mark - -----HCEmojiManager-----

static NSString *emojiPath = @"Resources.bundle/emoji";
static NSString *emojiType = @"json";

#endif /* HCHeader_h */
