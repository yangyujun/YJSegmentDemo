//
//  YJContentView.m
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJContentView.h"

#define kContentCellID @"kContentCellID"

@interface YJContentView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) NSArray *childVcs;
@property (nonatomic ,strong) UIViewController *parentVc;
@property (nonatomic ,assign) BOOL isForbidScrollDelegate;
@property (nonatomic ,assign) CGFloat startOffsetX;
@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation YJContentView

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentViewController:(UIViewController *)parentViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.childVcs = childVcs;
        self.parentVc = parentViewController;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    for (UIViewController *vc in _childVcs) {
        [_parentVc addChildViewController:vc];
    }
    [self addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _childVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
  
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIViewController *childVc = _childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _isForbidScrollDelegate = NO;
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (_isForbidScrollDelegate) { return; }

    CGFloat progress = 0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    // 判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.width;
    if (currentOffsetX > _startOffsetX) { // 左滑

        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        sourceIndex = (NSInteger)(currentOffsetX / scrollViewW);

        targetIndex = sourceIndex + 1;
        if (targetIndex >= _childVcs.count) {
            targetIndex = _childVcs.count - 1;
        }
        
        // 如果完全划过去
        if (currentOffsetX - _startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = sourceIndex;
        }
    } else { // 右滑
     
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        targetIndex = (NSInteger)currentOffsetX / scrollViewW;
     
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= _childVcs.count) {
            sourceIndex = _childVcs.count - 1;
        }
    }
   
    [_delegate contentView:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
     [_delegate contentViewEndScroll:self];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        [_delegate contentViewEndScroll:self];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    
    _isForbidScrollDelegate = YES;
    CGFloat offsetX = currentIndex * _collectionView.width;
    [_collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

#pragma mark - Getter Method
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.scrollsToTop = NO;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.frame = self.bounds;
        collectionView.pagingEnabled = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
        collectionView.backgroundColor = [UIColor clearColor];
        _collectionView = collectionView;
    }
    return _collectionView;
}


@end
