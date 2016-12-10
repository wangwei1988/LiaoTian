//
//  FunctionsView.m
//  聊天界面
//
//  Created by  王伟 on 2016/12/8.
//  Copyright © 2016年  王伟. All rights reserved.
//

#import "FunctionsView.h"
#import "imageCell.h"
#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenWidth   ScreenBounds.size.width
#define ScreenHeight  ScreenBounds.size.height
#define cellWidth (ScreenWidth )/ 4
#define cellHeight (ScreenWidth )/ 4
@interface FunctionsView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@end
@implementation FunctionsView
static NSString *identifier = @"Cell";
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
        [self createCollection];
    }
    return self;
}

- (void)createCollection {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[imageCell class] forCellWithReuseIdentifier:identifier];
}

#pragma mark - collerction datasource / delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    imageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        [cell.button setTitle:@"照片" forState:UIControlStateNormal];
        [cell.button setImage:[UIImage imageNamed:@"p"] forState:UIControlStateNormal];
    } else if (indexPath.row == 1) {
        [cell.button setTitle:@"拍照" forState:UIControlStateNormal];
        [cell.button setImage:[UIImage imageNamed:@"c"] forState:UIControlStateNormal];
    }
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        if (self.chooseImg) {
            self.chooseImg();
        }
    }
}



@end
