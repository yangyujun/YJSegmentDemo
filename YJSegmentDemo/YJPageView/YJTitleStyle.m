//
//  HYTitleStyle.m
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJTitleStyle.h"

@implementation YJTitleStyle

- (instancetype)init
{
    self = [super init];
    if (self) {
        /// 是否是滚动的Title
        _isScrollEnable = YES;
        /// 普通Title颜色 rgb(47, 196, 253)
        _normalColor = [UIColor colorWithR:47 g:196 b:253];
        /// 选中Title颜色 rgb(242, 67, 57)
        _selectedColor = [UIColor colorWithR:242 g:67 b:57];
        /// Title字体大小
        _font = [UIFont systemFontOfSize:14.0];
        /// 滚动Title的字体间距
        _titleMargin = 20;
        
        /// titleView的高度
        _titleHeight = 44;
        /// titleView的北京颜色
        _titleBgColor = [UIColor clearColor];
        
        /// 是否显示底部滚动条
        _isShowBottomLine = NO;
        /// 底部滚动条的颜色
        _bottomLineColor = [UIColor orangeColor];
        /// 底部滚动条的高度
        _bottomLineH = 2;
                
        /// 是否进行缩放
        _isNeedScale = NO;
        _scaleRange = 1.2;

        /// 是否显示遮盖
        _isShowCover = NO;
        /// 遮盖背景颜色
        _coverBgColor = [UIColor lightGrayColor];
        /// 文字&遮盖间隙
        _coverMargin = 5;
        /// 遮盖的高度
        _coverH = 25;
        /// 遮盖的宽度
        _coverW = 0;
        /// 设置圆角大小
        _coverRadius = 12;
    }
    return self;
}

@end
