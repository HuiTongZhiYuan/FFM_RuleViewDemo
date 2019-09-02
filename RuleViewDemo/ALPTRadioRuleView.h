//
//  ALPTRadioRuleView.h
//  RuleViewDemo
//
//  Created by lmy on 2019/7/21.
//  Copyright © 2019 zhh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALPTRadioRuleView;

@protocol ALPTRadioRuleViewDelegate <NSObject>

- (void)ruleViewDidScroll:(ALPTRadioRuleView *)ruleView pointValue:(CGFloat)value;

@end


@interface ALPTRadioRuleView : UIView
@property (nonatomic, strong)id<ALPTRadioRuleViewDelegate> delegate;

//直接设置指定到哪个位置
- (void)changeScrollViewContentOffSet:(CGFloat )pValue;

@end
