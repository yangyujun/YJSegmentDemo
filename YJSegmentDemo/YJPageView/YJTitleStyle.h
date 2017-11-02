//
//  HYTitleStyle.h
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YJTitleStyle : NSObject

/// 是否是滚动的Title
@property (nonatomic ,assign) BOOL isScrollEnable;
/// 普通Title颜色
@property (nonatomic ,strong) UIColor *normalColor;
/// 选中Title颜色
@property (nonatomic ,strong) UIColor *selectedColor;
/// Title字体大小
@property (nonatomic ,strong) UIFont *font;
/// 滚动Title的字体间距
@property (nonatomic ,assign) CGFloat titleMargin;
/// titleView的高
@property (nonatomic ,assign) CGFloat titleHeight;
/// titleView的北京颜色
@property (nonatomic ,strong) UIColor *titleBgColor;

/// 是否显示底部滚动条
@property (nonatomic ,assign) BOOL isShowBottomLine;
/// 底部滚动条的颜色
@property (nonatomic ,strong) UIColor *bottomLineColor;
/// 底部滚动条的高度
@property (nonatomic ,assign) CGFloat bottomLineH;

/// 是否进行缩放
@property (nonatomic ,assign) BOOL isNeedScale;

@property (nonatomic ,assign) CGFloat scaleRange;

/// 是否显示遮盖
@property (nonatomic ,assign) BOOL isShowCover;
/// 遮盖背景颜色
@property (nonatomic ,strong) UIColor *coverBgColor;
/// 文字&遮盖间隙
@property (nonatomic ,assign) CGFloat coverMargin;
/// 遮盖的高度
@property (nonatomic ,assign) CGFloat coverH;
/// 遮盖的宽度
@property (nonatomic ,assign) CGFloat coverW;
/// 设置圆角大小
@property (nonatomic ,assign) CGFloat coverRadius;

@end
