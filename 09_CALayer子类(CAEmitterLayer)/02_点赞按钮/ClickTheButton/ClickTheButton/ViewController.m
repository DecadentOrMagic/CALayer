//
//  ViewController.m
//  ClickTheButton
//
//  Created by 薛尧 on 2016/12/8.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "ViewController.h"

#import "XYEmitterButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     CAKeyframeAnimation       // 核心动画-关键帧动画
     CAEmitterLayer            // 粒子发射器(其实就是一个Layer,其父类是CALayer)
     CAEmitterCell             // 粒子
     
     CAEmitterLayer和CAEmitterCell，其实可以比喻成“炮”和“炮弹”,应该不难理解;
     */
    
    XYEmitterButton *button = [[XYEmitterButton alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"红色喜欢"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidClicked:(UIButton *)sender
{
    XYEmitterButton *button = (XYEmitterButton *)sender;
    button.selected = !button.selected;
}


























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
