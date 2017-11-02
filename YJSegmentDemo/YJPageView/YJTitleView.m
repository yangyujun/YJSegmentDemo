//
//  YJTitleView.m
//  YJSegmentDemo
//
//  Created by yyj on 2017/11/1.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJTitleView.h"

@interface YJTitleView()

@property (nonatomic ,strong) NSArray *titles;
@property (nonatomic ,assign) NSInteger currentIndex;
@property (nonatomic ,strong) YJTitleStyle *style;
@property (nonatomic ,strong) NSMutableArray *titleLabels;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic ,strong) UIView *splitLineView;
@property (nonatomic ,strong) UIView *bottomLine;
@property (nonatomic ,strong) UIView *coverView;

@end

@implementation YJTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles style:(YJTitleStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
        _titles = titles;
        _style = style;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
  
    self.backgroundColor = _style.titleBgColor;

    [self addSubview:self.scrollView];
    [self addSubview:self.splitLineView];
    
    [self setupTitleLabels];
    [self setupTitleLabelsPosition];
    
    if (_style.isShowBottomLine) {
        [self setupBottomLine];
    }

    if (_style.isShowCover) {
        [self setupCoverView];
    }
}

- (void)setupTitleLabels{
    
    _titleLabels = [NSMutableArray new];
    for (int index = 0; index < _titles.count; index++) {
        UILabel *label = [UILabel new];
        label.tag = index;
        label.text = _titles[index];
        label.textColor = (index == 0)? _style.selectedColor : _style.normalColor;
        label.font = _style.font;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tapGes];
        
        [_titleLabels addObject:label];
        [_scrollView addSubview:label];
    }

}

- (void)setupTitleLabelsPosition{
    
    CGFloat titleX = 0;
    CGFloat titleW = 0;
    CGFloat titleY = 0;
    CGFloat titleH = self.height;
    
    NSInteger count = _titleLabels.count;
    
    for (int index = 0; index < _titleLabels.count; index++) {
        UILabel *label = _titleLabels[index];
        if (_style.isScrollEnable) {
            CGRect rect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT,0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :_style.font} context:nil];
            titleW = rect.size.width;
            if (index == 0) {
                titleX = _style.titleMargin * 0.5;
            }else{
                UILabel *preLabel = _titleLabels[index-1];
                titleX = CGRectGetMaxX(preLabel.frame) + _style.titleMargin;
            }
        }else{
            titleW = self.width / count;
            titleX = titleW * index;
        }
        label.frame = CGRectMake(titleX, titleY, titleW, titleH);
        
        //放大
        if (index == 0) {
            CGFloat scale = _style.isNeedScale ? _style.scaleRange : 1.0;
            label.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }
    
    if (_style.isScrollEnable) {
        UILabel *lastLabel = _titleLabels.lastObject;
        _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame) + _style.titleMargin * 0.5, 0);
    }
}

- (void)setupBottomLine{
    
    [_scrollView addSubview:self.bottomLine];
    UILabel *firstLabel = _titleLabels.firstObject;
    _bottomLine.frame = CGRectMake(firstLabel.x,self.bounds.size.height - _style.bottomLineH, firstLabel.frame.size.width, _style.bottomLineH);
}

- (void)setupCoverView{
    
    [_scrollView insertSubview:self.coverView atIndex:0];
    UILabel *firstLabel = _titleLabels.firstObject;
    
    CGFloat coverW = firstLabel.width;
    CGFloat coverH = _style.coverH;
    CGFloat coverX = firstLabel.x;
    CGFloat coverY = (self.bounds.size.height - _style.coverH) * 0.5;
    
    if (_style.isScrollEnable) {
        coverX -= _style.coverMargin;
        coverW += _style.coverMargin * 2;
    }
    _coverView.frame = CGRectMake(coverX, coverY, coverW, coverH);
    
    _coverView.layer.cornerRadius = _style.coverRadius;
    _coverView.layer.masksToBounds = YES;
    
}

- (void)titleLabelClick:(UITapGestureRecognizer *)tap{
    
    UILabel *currentLabel = (UILabel *)tap.view;
    
    if (_currentIndex == currentLabel.tag ) {
        return;
    }
    UILabel *oldLabel = (UILabel *)_titleLabels[_currentIndex];
    currentLabel.textColor = _style.selectedColor;
    oldLabel.textColor = _style.normalColor;
    
    _currentIndex = currentLabel.tag;
    [_delegate titleView:self selectedIndex:_currentIndex];
  
    [self contentViewDidEndScroll];

    if (_style.isShowBottomLine) {
        [UIView animateWithDuration:0.15 animations:^{
            _bottomLine.x = currentLabel.x;
            _bottomLine.width = currentLabel.width;
        }];
    }

    if (_style.isNeedScale) {
        oldLabel.transform = CGAffineTransformIdentity;
        currentLabel.transform =  CGAffineTransformMakeScale(_style.scaleRange, _style.scaleRange);
    }
   
    if (_style.isShowCover) {
        CGFloat coverX = _style.isScrollEnable ? (currentLabel.x - _style.coverMargin) : currentLabel.x;
        CGFloat coverW = _style.isScrollEnable ? (currentLabel.width + _style.coverMargin * 2) : currentLabel.width;
        [UIView animateWithDuration:0.15 animations:^{
            _coverView.x = coverX;
            _coverView.width = coverW;
        }];
    }
}

- (void)setTitleWithProgress:(CGFloat )progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex{

    UILabel *sourceLabel = _titleLabels[sourceIndex];
    UILabel *targetLabel = _titleLabels[targetIndex];
  
    const CGFloat *normalComponents = CGColorGetComponents(_style.normalColor.CGColor);
    const CGFloat *selectedComponents = CGColorGetComponents(_style.selectedColor.CGColor);
    
    double colorDeltaR = selectedComponents[0] - normalComponents[0];
    double colorDeltaG = selectedComponents[1] - normalComponents[1];
    double colorDeltaB = selectedComponents[2] - normalComponents[2];

    sourceLabel.textColor = [UIColor colorWithRed:(selectedComponents[0] - colorDeltaR * progress) green:(selectedComponents[1] - colorDeltaG * progress) blue:(selectedComponents[2] - colorDeltaB * progress) alpha:1.0];
    targetLabel.textColor = [UIColor colorWithRed:(normalComponents[0] + colorDeltaR * progress) green:(normalComponents[1] + colorDeltaG * progress) blue:(normalComponents[2] + colorDeltaB * progress) alpha:1.0];

    _currentIndex = targetIndex;
    
    CGFloat moveTotalX = targetLabel.x - sourceLabel.x;
    CGFloat moveTotalW = targetLabel.width - sourceLabel.width;
    
    if (_style.isShowBottomLine) {
        _bottomLine.width = sourceLabel.width + moveTotalW * progress;
        _bottomLine.x = sourceLabel.x + moveTotalX * progress;
    }
    
    if (_style.isNeedScale) {
        CGFloat scaleDelta = (_style.scaleRange - 1.0) * progress;
        sourceLabel.transform = CGAffineTransformMakeScale(_style.scaleRange - scaleDelta, _style.scaleRange - scaleDelta);
        targetLabel.transform = CGAffineTransformMakeScale(1.0 + scaleDelta, 1.0 + scaleDelta);
    }
    
    if (_style.isShowCover) {
        _coverView.width = _style.isScrollEnable ? (sourceLabel.width + 2 * _style.coverMargin + moveTotalW * progress) : (sourceLabel.width + moveTotalW * progress);
        _coverView.x = _style.isScrollEnable ? (sourceLabel.x - _style.coverMargin + moveTotalX * progress) : (sourceLabel.x + moveTotalX * progress);
    }
}

- (void)contentViewDidEndScroll{
    
    if (!_style.isScrollEnable) {
        return;
    }
  
    UILabel *targetLabel = _titleLabels[_currentIndex];

    CGFloat offSetX = targetLabel.center.x - self.width * 0.5;
    if (offSetX < 0) {
        offSetX = 0;
    }
    
    CGFloat maxOffset = _scrollView.contentSize.width - self.width;
    if (offSetX > maxOffset) {
        offSetX = maxOffset;
    }
    [_scrollView setContentOffset:CGPointMake(offSetX, 0) animated:YES];

}

#pragma mark - Getter Methods
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [UIScrollView new];
        scrollView.frame = self.bounds;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        _scrollView = scrollView;
    }
    return _scrollView;
}

-(UIView *)splitLineView{
    if (!_splitLineView) {
        UIView *splitLineView = [UIView new];
        splitLineView.backgroundColor = [UIColor lightGrayColor];
        CGFloat h = 0.5;
        splitLineView.frame = CGRectMake(0, self.frame.size.height - h, self.frame.size.width, h);
        _splitLineView = splitLineView;
    }
    return _splitLineView;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        UIView *bottomLine = [UIView new];
        bottomLine.backgroundColor = _style.bottomLineColor;
        _bottomLine = bottomLine;
    }
    return _bottomLine;
}
-(UIView *)coverView{
    if (!_coverView) {
        UIView *coverView = [UIView new];
        coverView.backgroundColor = _style.coverBgColor;
        coverView.alpha = 0.7;
        _coverView = coverView;
    }
    return _coverView;
}

@end
