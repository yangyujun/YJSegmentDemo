//
//  YJPageView.m
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJPageView.h"
#import "YJTitleView.h"
#import "YJContentView.h"

@interface YJPageView()<YJTitleViewDelegate,YJContentViewDelegate>

@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,strong) YJTitleStyle *style;
@property (nonatomic ,strong) NSArray *childVcs;
@property (nonatomic ,strong) UIViewController *parentVc;
@property (nonatomic ,strong) YJTitleView *titleView;
@property (nonatomic ,strong) YJContentView *contentView;

@end

@implementation YJPageView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(YJTitleStyle *)style childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc
{
    self = [super initWithFrame:frame];
    if (self) {
        _style = style;
        _titles = titles;
        _childVcs = childVcs;
        _parentVc = parentVc;
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    CGFloat titleH = _style.titleHeight;
    CGRect titleFrame = CGRectMake(0, 0, self.width, titleH);
   
    _titleView = [[YJTitleView alloc]initWithFrame:titleFrame titles:_titles style:_style];
    _titleView.delegate = self;
    [self addSubview:_titleView];
    
    CGRect contentFrame = CGRectMake(0, titleH, self.width, self.height - titleH);
    _contentView = [[YJContentView alloc] initWithFrame:contentFrame childVcs:_childVcs parentViewController:_parentVc];
    _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _contentView.delegate = self;
    [self addSubview:_contentView];
}

#pragma mark - YJTitleViewDelegate Method
- (void)titleView:(YJTitleView *)titleView selectedIndex:(NSInteger)index{
    [_contentView setCurrentIndex:index];
}

#pragma mark - YJContentViewDelegate Method
- (void)contentView:(YJContentView *)contentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex{
    
    [_titleView setTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

- (void)contentViewEndScroll:(YJContentView *)contentView{
    
    [_titleView contentViewDidEndScroll];
}
@end
