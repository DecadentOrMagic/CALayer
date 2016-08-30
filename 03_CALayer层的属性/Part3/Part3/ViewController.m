//
//  ViewController.m
//  Part3
//
//  Created by 薛尧 on 16/8/18.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 位置和锚点
    [self positionAndAnchorPoint];
}

#pragma mark - 位置和锚点
- (void)positionAndAnchorPoint
{
    /**
     *  简单介绍
     *  CALayer有2个非常重要的属性：position和anchorPoint
     *  @property CGPoint position;
            用来设置CALayer在父层中的位置
            以父层的左上角为原点(0, 0)
     *  @property CGPoint anchorPoint;
            称为“定位点”、“锚点”
            决定着CALayer身上的哪个点会在position属性所指的位置
            以自己的左上角为原点(0, 0)
            它的x、y取值范围都是0~1，默认值为（0.5, 0.5）
     */
    
    // 默认锚点
//    [self defaultAnchorPoint];
    // 锚点为(0,0)点
//    [self anchorPointAt00];
    // 锚点为(1,1)点
//    [self anchorPointAt11];
    
    // 隐式动画
    [self yinshidonghua];
}




//----------------------------------------------------------------//
//---------------- 位置和锚点 -------------------//

#pragma mark - 默认锚点
- (void)defaultAnchorPoint
{
    CALayer *layer = [CALayer layer];
    // 设置层的宽度和高度（100x100）
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 设置层的位置
    layer.position = CGPointMake(100, 100);
    // 设置层的背景颜色：红色
    layer.backgroundColor = [UIColor redColor].CGColor;
    // 添加myLayer到控制器的view的layer中
    [self.view.layer addSublayer:layer];
    
    // 设置了layer的position为(100, 100)，又因为anchorPoint默认是(0.5, 0.5)，所以最后的效果是：layer的中点会在父层的(100, 100)位置
}

#pragma mark - 锚点为(0,0)点
- (void)anchorPointAt00
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.anchorPoint = CGPointMake(0, 0);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    // anchorPoint改为(0, 0)，layer的左上角会在(100, 100)位置
}

#pragma mark - 锚点为(1,1)点
- (void)anchorPointAt11
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.anchorPoint = CGPointMake(1, 1);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    // anchorPoint改为(1, 1)，layer的右下角会在(100, 100)位置
}

#pragma mark - 锚点为(0,1)点
- (void)anchorPoint01
{
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    layer.anchorPoint = CGPointMake(0, 1);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    // anchorPoint改为(0, 1)，layer的左下角会在(100, 100)位置
}




//----------------------------------------------------------------//
//---------------- 隐式动画 -------------------//

#pragma mark - 隐式动画
- (void)yinshidonghua
{
    /**
     *  简单说明
     *  每一个UIView内部都默认关联着一个CALayer，我们可用称这个Layer为Root Layer（根层）
     *  所有的非Root Layer，也就是手动创建的CALayer对象，都存在着隐式动画
     *  什么是隐式动画？
     *      当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果
     *      而这些属性称为Animatable Properties(可动画属性)
     *  列举几个常见的Animatable Properties：
     *      bounds：用于设置CALayer的宽度和高度。修改这个属性会产生缩放动画
     *      backgroundColor：用于设置CALayer的背景色。修改这个属性会产生背景色的渐变动画
     *      position：用于设置CALayer的位置。修改这个属性会产生平移动画
     */
    
    // 如何查看CALayer的某个属性是否支持隐式动画? 可以查看头文件，看有没有Animatable，如果有则表示支持。
    
    // 创建图层
    CALayer *mylayer = [CALayer layer];
    // 设置图层属性
    mylayer.backgroundColor = [UIColor brownColor].CGColor;
    mylayer.bounds = CGRectMake(0, 0, 150, 100);
    // 显示位置
    mylayer.position = CGPointMake(100, 100);
    mylayer.anchorPoint = CGPointZero;
    mylayer.cornerRadius = 20;
    // 添加图层
    [self.view.layer addSublayer:mylayer];
    self.layer = mylayer;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // http://liuyanwei.jumppo.com/2015/11/16/iOS-Implicit-Animation.html
    
    [self customYinshidonghua];
//    [self closeYinshidonghua];
}

#pragma mark - 系统隐式动画
- (void)customYinshidonghua
{
    // 隐式动画
    self.layer.bounds = CGRectMake(0, 0, 200, 60);
    self.layer.backgroundColor = [UIColor yellowColor].CGColor;
}

#pragma mark - 关闭隐式动画
- (void)closeYinshidonghua
{
    // layer隐式动画实际上是自动执行了CATransaction，通过begin和commit进行入栈和出栈，并再run loop中执行一次0.25秒的隐式动画。
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    // 隐式动画
    self.layer.bounds = CGRectMake(0, 0, 200, 60);
    self.layer.backgroundColor = [UIColor yellowColor].CGColor;
    
    [CATransaction commit];
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
