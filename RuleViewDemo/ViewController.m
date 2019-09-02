//
//  ViewController.m
//  RuleViewDemo
//
//  Created by 张豪豪 on 16/11/10.
//  Copyright © 2016年 zhh. All rights reserved.
//

#import "ViewController.h"
#import "ALPTRadioRuleView.h"


@interface ViewController ()<ALPTRadioRuleViewDelegate>
@property(nonatomic,strong)UILabel * lable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];

    
    ALPTRadioRuleView * ruleView = [[ALPTRadioRuleView alloc] initWithFrame:CGRectMake(100, 100, 800/3, 90/3)];
    [self.view addSubview:ruleView];
    ruleView.delegate = self;
    [ruleView changeScrollViewContentOffSet:875];
    
    _lable =[[UILabel alloc] initWithFrame:CGRectMake(150, 60, 200, 40)];
    [self.view addSubview:_lable];
}

- (void)ruleViewDidScroll:(ALPTRadioRuleView *)ruleView pointValue:(CGFloat)value {
    
    _lable.text = [NSString stringWithFormat:@"%0.1f",value/10];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
