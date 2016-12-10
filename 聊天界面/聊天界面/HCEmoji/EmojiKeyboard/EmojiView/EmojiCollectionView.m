
//  Created by Caoyq on 16/5/12.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "EmojiCollectionView.h"
#import "HCEmojiManager.h"
#import "HCHeader.h"
#import "SinglePageEmojiCell.h"

@interface EmojiCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIPageControl *indexPC;/**< 页数显示 */

@end

@implementation EmojiCollectionView

#pragma mark - Init
- (instancetype)init {
    self = [super init];
    self.backgroundColor = [UIColor emojiBgColor];
    self.frame = CGRectMake(0, 0, ScreenWidth, kCollectionHeight+kPageControlHeight);
    if (self) {
        _dataSource = [[HCEmojiManager sharedEmoji] getEmojisDataSourceFromLocal];
        [self addSubview:self.emojiCollection];
        [self addSubview:self.indexPC];
        [self.emojiCollection addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark - 初始化
+ (EmojiCollectionView *)sharedCollection {
    return [self new];
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [_emojiCollection reloadData];
//    _indexPC = nil;
//    [self indexPC];
}

#pragma mark - Lazy load
- (UICollectionView *)emojiCollection {
    if (!_emojiCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layout setItemSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-kPageControlHeight)];
        [layout setMinimumLineSpacing:0];
        [layout setMinimumInteritemSpacing:0];
        
        _emojiCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-kPageControlHeight) collectionViewLayout:layout];
        [_emojiCollection setPagingEnabled:YES];
        [_emojiCollection setBounces:YES];
        _emojiCollection.delegate = self;
        _emojiCollection.dataSource = self;
        [_emojiCollection setContentSize:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-kPageControlHeight)];
        [_emojiCollection setShowsHorizontalScrollIndicator:NO];
        _emojiCollection.backgroundColor = [UIColor clearColor];
        [_emojiCollection registerClass:[SinglePageEmojiCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _emojiCollection;
}

- (UIPageControl *)indexPC {
    if (!_indexPC) {
        _indexPC = [[UIPageControl alloc]init];
        _indexPC.frame = CGRectMake(0, CGRectGetHeight(_emojiCollection.frame), CGRectGetWidth(self.bounds), kPageControlHeight);
        _indexPC.numberOfPages = ceil(_dataSource.count/kPageCount);
        _indexPC.currentPage = 0;
        _indexPC.pageIndicatorTintColor = [UIColor pageIndicatorTintColor];
        _indexPC.currentPageIndicatorTintColor = [UIColor currentPageIndicatorTintColor];
        _indexPC.backgroundColor = [UIColor clearColor];
    }
    
    return _indexPC;
}


#pragma mark - uicollectionview datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ceil(_dataSource.count/kPageCount);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"row = %ld,section = %ld",indexPath.row,indexPath.section);
    SinglePageEmojiCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NSIndexSet *indexSet = nil;
    if (indexPath.row < ceil(_dataSource.count/kPageCount)-1) {
        indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(kPageCount*indexPath.row, kPageCount)];
    }else{
        NSInteger leng = _dataSource.count - kPageCount*indexPath.row;
        indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(kPageCount*indexPath.row, leng)];
    }
    
    if (_dataSource) {
        cell.dataSource = [_dataSource objectsAtIndexes:indexSet];
    }

    return cell;
}

#pragma mark - KVO监控
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat offset = _emojiCollection.contentOffset.x;
        int count = offset/ScreenWidth;
        _indexPC.currentPage = count;
    }
}

#pragma mark - 注销
- (void)dealloc {
    [_emojiCollection removeObserver:self forKeyPath:@"contentOffset"];
}

@end
