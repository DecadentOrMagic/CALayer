//
//  ViewController.m
//  Part5
//
//  Created by 薛尧 on 16/8/22.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

#define WIDTH 200

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // http://blog.csdn.net/maylorchao/article/details/42652161
    
    
    // CALayer 常用属性
    [self inCommonUse];
}



//----------------------------------------------------------------//
//---------------- CALayer常用属性 -------------------//

#pragma mark - CALayer 常用属性
- (void)inCommonUse
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    // 获得根图层
    CALayer *layer = [CALayer layer];
    // 获取背景颜色
    layer.backgroundColor = [UIColor colorWithRed:0 green:146 / 255.0 blue:1.0 alpha:1.0].CGColor;
    // 设置中心点
    layer.position = CGPointMake(size.width / 2, size.height / 2);
    // 设置大小
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    // 设置圆角,当圆角半径等于矩形的一半时看起来就是一个圆形
    layer.cornerRadius = WIDTH / 2;
    // 设置阴影
    layer.shadowColor = [UIColor grayColor].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 0.9;
//    // 设置边框
//    layer.borderColor = [UIColor whiteColor].CGColor;
//    layer.borderWidth = 1;
//    // 设置锚点
//    layer.anchorPoint = CGPointZero;
    [self.view.layer addSublayer:layer];
}

#pragma mark - 点击放大
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CALayer *layer = self.view.layer.sublayers[2];
    CGFloat width = layer.bounds.size.width;
    if (width == WIDTH) {
        width = WIDTH / 4;
    }
    else {
        width = WIDTH;
    }
    layer.bounds = CGRectMake(0, 0, width, width);
    layer.position = [touch locationInView:self.view];
    layer.cornerRadius = width / 2;
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
