//
//  YJTitleView.h
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTitleStyle.h"
@class YJTitleView;

@protocol  YJTitleViewDelegate

- (void)titleView:(YJTitleView *)titleView selectedIndex:(NSInteger)index;

@end

@interface YJTitleView : UIView

@property (nonatomic , weak) id<YJTitleViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(YJTitleStyle *)style;

- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;
- (void)contentViewDidEndScroll;
@end


