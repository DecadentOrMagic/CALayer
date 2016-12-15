//
//  ViewController.m
//  CAReplicatorLayerDemo
//
//  Created by 薛尧 on 2016/12/13.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     CAReplicatorLayer
     
     1.CAReplicatorLayer的目的是为了高效生成许多相似的图层.它是可以复制自己子层的layer,并且复制出来的layer和原生子层有同样的属性，位置，形变，动画。
     2.CAReplicatorLayer的属性
         //拷贝的次数
         @property NSInteger instanceCount;
         //是否开启景深效果
         @property BOOL preservesDepth;
         //当CAReplicatorLayer的子Layer层进行动画的时候，拷贝的副本执行动画的延时
         @property CFTimeInterval instanceDelay;
         //拷贝副本的3D变换
         @property CATransform3D instanceTransform;
         //拷贝副本的颜色变换
         @property(nullable) CGColorRef instanceColor;
         //每个拷贝副本的颜色偏移参数
         @property float instanceRedOffset;
         @property float instanceGreenOffset;
         @property float instanceBlueOffset;
         //每个拷贝副本的透明度偏移参数
         @property float instanceAlphaOffset;
     */
    
    [self volumeBar];
}

- (void)volumeBar
{
    // 创建图层
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    // 创建图层的位置为控制器view的中心点
    replicator.position = self.view.center;
    // 设置复制层的大小(任意取值)
    replicator.bounds = CGRectMake(0, 0, 250, 250);
    // 设置复制层的背景颜色
    replicator.backgroundColor = [UIColor lightGrayColor].CGColor;
    // 将复制层添加到控制器的layer上
    [self.view.layer addSublayer:replicator];
    
    // 创建一个振动层
    CALayer *vibrateLayer = [CALayer layer];
    // 振动层的宽高
    CGFloat width = 25;
    CGFloat height = 100;
    vibrateLayer.bounds = CGRectMake(0, 0, width, height);
    // 给定振动层的锚点
    vibrateLayer.anchorPoint = CGPointMake(0.5, 1);
    // 设置振动层的位置
    vibrateLayer.position = CGPointMake(width * 0.5, replicator.bounds.size.height);
    // 设置振动层的圆角
    vibrateLayer.cornerRadius = 10;
    // 设置振动层的背景颜色
    vibrateLayer.backgroundColor = [UIColor magentaColor].CGColor;
    // 将需要被复制的振动层添加到赋值层上
    [replicator addSublayer:vibrateLayer];
    
    // 创建帧动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    // 动画执行的持续时间
    anim.duration = 1;
    // 修改的属性
    anim.values = @[@(1), @(0.5), @(0)];
    // 旋转后再旋转到原来的位置,反极性开始
    anim.autoreverses = YES;// 当为true时,对象在向前播放后向后播放
    anim.repeatCount = MAXFLOAT;
    [vibrateLayer addAnimation:anim forKey:nil];
    
    // 设置复制层需要复制的个数
    replicator.instanceCount = 4;
    // 设置复制出来子层的位移
    replicator.instanceTransform = CATransform3DMakeTranslation(50, 0, 0);
    // 执行动画的延迟
    replicator.instanceDelay = 0.1;
    // 改变颜色
    replicator.instanceAlphaOffset = -0.1;
    replicator.instanceRedOffset = -0.2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
