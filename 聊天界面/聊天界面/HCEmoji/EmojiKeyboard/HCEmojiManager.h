
//  Created by Caoyq on 16/5/13.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCHeader.h"

@interface HCEmojiManager : NSObject

#pragma mark - -----Properties-----

@property (strong, nonatomic) NSMutableArray *emojisAry;
@property (strong, nonatomic) NSMutableArray *usedEmojiAry;
@property (assign, nonatomic) NSInteger selectedRow;

#pragma mark - -----Methods------
/**
 *初始化一个HCEmojiManager单例对象
 */
+ (instancetype)sharedEmoji;

/**
 *将选择过的表情存在·UsedEmojiAry·数组中
 *@param   object   选择过的表情
 *@return  void
 */
- (void)addUsedEmojiAryObject:(NSString *)object;

/**
 *根据row来获取表情数据源
 *@return  表情数据源（NSArray）
 */
- (NSArray *)getEmojisDataSourceFromLocal;

#pragma mark - NSUserDefaults 存取数据
/**
 *将使用过的表情存入本地
 *@param   ary   选中的row
 *@return  void
 */
- (void)saveUsedEmojisToLocal:(NSMutableArray *)ary;

/**
 *从本地取出使用过的表情
 *@return  NSMutableArray
 */
- (NSMutableArray *)getLocalUsedEmojis;

- (void)clearUsedEmojis;
@end
