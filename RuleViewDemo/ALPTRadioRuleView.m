//
//  ALPTRadioRuleView.m
//  RuleViewDemo
//
//  Created by lmy on 2019/7/21.
//  Copyright © 2019 zhh. All rights reserved.
//

#import "ALPTRadioRuleView.h"

@interface ALPTRadioRuleView()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;//!< 刻度尺
@property (nonatomic, strong)UIView *pointView;//!< 指针

@property (nonatomic, assign)NSInteger pointValue;//!< 指针指向的值
@end


#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:1.0]


@implementation ALPTRadioRuleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_scrollView];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        _scrollView.delegate = self;
        
        _pointView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2.0-0.5, 0, 2, self.scrollView.frame.size.height)];
        _pointView.backgroundColor = UIColorFromHex(0xFF5252);
        [self addSubview:_pointView];
        
        [self addAllLine];
    }
    return self;
}

- (void)addAllLine{
    
    CGFloat fromX= 0;
    CGFloat y = 38/3;
    for (int i = 0; i < 1180; i++) {   //1080
        
        if (i%10==0) {
            y = 38/3;
        }
        else if (i%10==5) {
            y = 56/3;
        }else{
            y = 68/3;
        }
        UILabel * lineLable = [[UILabel alloc] initWithFrame:CGRectMake(fromX, y, 1, (self.frame.size.height-y))];
        [lineLable setBackgroundColor:[UIColor whiteColor]];
        [self.scrollView addSubview:lineLable];
        
        fromX=(fromX+9);
        
        [self.scrollView setContentSize:CGSizeMake(fromX,self.scrollView.frame.size.height)];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat ruleLength = self.frame.size.width/2;
    CGFloat contentOffSetX  = (scrollView.contentOffset.x + ruleLength)/9;
    
    NSInteger intSetX = contentOffSetX;
    
    if (contentOffSetX > (intSetX+0.5)) {
        self.pointValue = intSetX+1;
    }else{
        self.pointValue = intSetX;
    }
    
    if (self.pointValue>1080) {
        self.pointValue = 875;
        [self controlScrollViewContentOffSet];
    }
    else if (self.pointValue < 875){
        self.pointValue = 1080;
        [self controlScrollViewContentOffSet];
    }
    if ([self.delegate respondsToSelector:@selector(ruleViewDidScroll:pointValue:)]) {
        [self.delegate ruleViewDidScroll:self pointValue:self.pointValue];
    }
    NSLog(@"刻度刻度1： %ld",(long)self.pointValue);
}

//调控偏移的距离
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self controlScrollViewContentOffSet];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self controlScrollViewContentOffSet];
}

- (void)controlScrollViewContentOffSet {
    CGFloat ruleLength = self.frame.size.width/2; //133
    self.scrollView.contentOffset = CGPointMake(self.pointValue*9-ruleLength, 0);
    NSLog(@"刻度刻度2： %ld",(long)self.pointValue);
    
    if ([self.delegate respondsToSelector:@selector(ruleViewDidScroll:pointValue:)]) {
        [self.delegate ruleViewDidScroll:self pointValue:self.pointValue];
    }
}

- (void)changeScrollViewContentOffSet:(CGFloat )pValue {
    
    self.pointValue = pValue;//!< 指针指向的值
    [self controlScrollViewContentOffSet];
}
@end
