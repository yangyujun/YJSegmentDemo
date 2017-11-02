//
//  ViewController.m
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "ViewController.h"
#import "YJPageView.h"
#import "YJTitleStyle.h"
#import "ContentController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    YJTitleStyle *style = [YJTitleStyle new];
    style.isScrollEnable = YES;
    style.isNeedScale = YES;
    style.isShowBottomLine = YES;
    style.bottomLineColor = [UIColor purpleColor];
    style.isShowCover = YES;
    NSArray *titles = @[@"呵呵",@"记得上飞机",@"水电费",@"放大",@"积极",@"好嗲是否hi阿德",@"大师傅",@"发动机"];
    
    NSMutableArray *childVcs = [NSMutableArray new];
    for (int i = 0; i < titles.count; i++) {
        ContentController *contentVC = [ContentController new];
        [childVcs addObject:contentVC];
    }
    
    YJPageView *pageView = [[YJPageView alloc] initWithFrame:CGRectMake(0, 60, self.view.width, self.view.height) titles:titles style:style childVcs:childVcs parentVc:self];
    [self.view addSubview:pageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
