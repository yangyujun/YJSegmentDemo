//
//  YJContentView.h
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YJContentView;

@protocol YJContentViewDelegate

- (void)contentView:(YJContentView *)contentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

- (void)contentViewEndScroll:(YJContentView *)contentView;
@end

@interface YJContentView : UIView

@property (nonatomic ,weak) id<YJContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentViewController:(UIViewController *)parentViewController;

- (void)setCurrentIndex:(NSInteger)currentIndex;

@end
