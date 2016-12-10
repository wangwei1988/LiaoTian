
//  Created by Caoyq on 16/5/16.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "SinglePageEmojiCell.h"
#import "HCEmojiManager.h"
#import "EmojiCell.h"
#import "HCHeader.h"

#define kRowCount    21

static NSString *emojiCell = @"EmojiCell";


@interface SinglePageEmojiCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *singleCollction;
@property (strong, nonatomic) HCEmojiManager *emojiManager;

@end
@implementation SinglePageEmojiCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.singleCollction];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Lazy load
- (UICollectionView *)singleCollction {
    if (!_singleCollction) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        
        [layout setItemSize:CGSizeMake(kIconSize, kIconSize)];
        [layout setSectionInset:UIEdgeInsetsMake(kIconTop, kIconLeft, kIconTop, kIconLeft)];
        [layout setMinimumLineSpacing:kIconTop];
        [layout setMinimumInteritemSpacing:kIconLeft];
        
        _singleCollction = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)) collectionViewLayout:layout];
        _singleCollction.delegate = self;
        _singleCollction.dataSource = self;
        _singleCollction.backgroundColor = [UIColor clearColor];
        [_singleCollction registerClass:[EmojiCell class] forCellWithReuseIdentifier:emojiCell];
    }
    return _singleCollction;
}

#pragma mark - set dataSource
//在代理方法运行之前运行
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [_singleCollction reloadData];
}

#pragma mark - Collection View DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kRowCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:emojiCell forIndexPath:indexPath];
    if (indexPath.row == 20) {
        [cell.lab setTitle:@"" forState:UIControlStateNormal];
        cell.img.hidden = NO;
        cell.img.image = ImgName(delete);
        return cell;
    }
    if (_dataSource && indexPath.row < _dataSource.count) {
        [cell.lab setTitle:_dataSource[indexPath.row] forState:UIControlStateNormal];
    }else{
        [cell.lab setTitle:@"" forState:UIControlStateNormal];
    }
    cell.img.hidden = YES;
    return cell;
}

#pragma mark - CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EmojiCell *cell = (EmojiCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == kRowCount-1) {
        //删除表情 发送通知
        [self postNotificationName:@"delete" object:nil];
    }else{
        //选中表情 发送通知
        [[HCEmojiManager sharedEmoji] addUsedEmojiAryObject:cell.lab.titleLabel.text];
        [self postNotificationName:@"selected" object:cell.lab.titleLabel.text];
    }
}

#pragma mark - 表情选中或删除 发送通知
- (void)postNotificationName:(NSString *)name object:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:object];
}
@end
