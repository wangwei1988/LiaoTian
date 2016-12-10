
//  Created by Caoyq on 16/5/13.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "HCEmojiManager.h"

@interface HCEmojiManager ()

@end
@implementation HCEmojiManager

#pragma mark - Init
+ (instancetype)sharedEmoji {
    static HCEmojiManager *emoji = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emoji = [[HCEmojiManager alloc]init];
    });
    return emoji;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self emojisAry];
        [self usedEmojiAry];
    }
    return self;
}

#pragma mark - Lazy load
- (NSMutableArray *)emojisAry {
    if (!_emojisAry) {
        NSDictionary *dic = [self getEmojisDic];
        _emojisAry = [NSMutableArray new];
        [_emojisAry addObjectsFromArray:dic[@"normal"]];
    }
    return _emojisAry;
}

- (NSMutableArray *)usedEmojiAry {
    if (!_usedEmojiAry) {
        _usedEmojiAry = [self getLocalUsedEmojis];
    }
    return _usedEmojiAry;
}

- (void)addUsedEmojiAryObject:(NSString *)object{
    for (NSString *str in self.usedEmojiAry){
        if ([str isEqualToString:object]) {
            [_usedEmojiAry removeObject:object];
            break;
        }
    }
    [self.usedEmojiAry insertObject:object atIndex:0];
    [self saveUsedEmojisToLocal:_usedEmojiAry];
}

- (NSArray *)getEmojisDataSourceFromLocal {
    NSInteger row = _selectedRow;
    NSArray *ary = [NSArray new];
    switch (row) {
        case 0:
            ary = self.emojisAry;
            break;
        case 1:
            ary = self.usedEmojiAry;
            break;
        default:
            break;
    }
    return ary;
}

#pragma mark - NSUserDefaults  本地数据存取 、清空
- (void)saveUsedEmojisToLocal:(NSMutableArray *)ary {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:ary forKey:@"UsedEmojis"];
    [defaults synchronize];
}

- (NSMutableArray *)getLocalUsedEmojis{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *ary = [defaults objectForKey:@"UsedEmojis"];
    [defaults synchronize];
    NSMutableArray *returnAry = [NSMutableArray new];
    //从本地取出来的数组是NSCFArray类型 不是 NSMutableArray
    if (ary != nil) {
        [returnAry addObjectsFromArray:ary];
    }
    return returnAry;
}

- (void)clearUsedEmojis {
    //清空表情数据
}

#pragma mark - 解析json 数据
- (NSDictionary *)getEmojisDic{
    static NSDictionary *__emojisDic = nil;
    if (!__emojisDic){
        NSString *path = [[NSBundle mainBundle] pathForResource:emojiPath ofType:emojiType];
        NSData *emojiData = [[NSData alloc] initWithContentsOfFile:path];
        __emojisDic = [NSJSONSerialization JSONObjectWithData:emojiData options:NSJSONReadingAllowFragments error:nil];
    }
    return __emojisDic;
}

@end
