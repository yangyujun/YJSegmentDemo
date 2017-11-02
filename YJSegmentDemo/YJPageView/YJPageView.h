//
//  YJPageView.h
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJTitleStyle.h"

@interface YJPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(YJTitleStyle *)style childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc;

@end
