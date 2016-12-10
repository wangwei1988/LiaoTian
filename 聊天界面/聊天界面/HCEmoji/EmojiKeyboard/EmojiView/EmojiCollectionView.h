
//  Created by Caoyq on 16/5/12.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EmojiDeletedBlock)(void);
typedef void (^EmojiSelectedBlock)(NSString *emojiItem);

@interface EmojiCollectionView : UIView

#pragma mark - 属性
@property (strong, nonatomic) UICollectionView *emojiCollection;/**<表情显示页面 */
@property (strong, nonatomic) NSArray *dataSource;/**<表情数据源*/
@property (strong, nonatomic) EmojiDeletedBlock deletedBlock;
@property (strong, nonatomic) EmojiSelectedBlock selectedBlock;

#pragma mark - 方法

/**
 *初始化一个EmojiCollectionView对象
 *@param   初始化的对象    宽高不可修改
 */
+ (EmojiCollectionView *)sharedCollection;

@end
