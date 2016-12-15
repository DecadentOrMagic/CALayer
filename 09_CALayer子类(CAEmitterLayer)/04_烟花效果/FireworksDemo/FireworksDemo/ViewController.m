//
//  ViewController.m
//  FireworksDemo
//
//  Created by 薛尧 on 2016/12/15.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAEmitterLayer *caElayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self fireworks];
}

- (void)fireworks
{
    self.view.backgroundColor = [UIColor blackColor];
    
    self.caElayer = [CAEmitterLayer layer];
    // 发射源位置
    self.caElayer.emitterPosition = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 50);
    // 发射源尺寸大小((发射形状的大小。默认为（0，0，0）。动画。根据`emitShape'属性，一些值可能会被忽略。))
    self.caElayer.emitterSize = CGSizeMake(50, 0);
    // 发射源模式
    self.caElayer.emitterMode = kCAEmitterLayerOutline;
    // 发射源的形状
    self.caElayer.emitterShape = kCAEmitterLayerLine;
    // 渲染模式
    self.caElayer.renderMode = kCAEmitterLayerAdditive;
    // 发射速度
    self.caElayer.velocity = 1;
    // 随机产生粒子
    self.caElayer.seed = (arc4random() % 100) + 1;// 用于初始化随机数产生的粒子
    
    // cell
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    // 每秒创建的发射对象的数量
    cell.birthRate = 1.0;
    // 发射的角度
    cell.emissionRange = 0.11 * M_PI;
    // 速度
    cell.velocity = 300;
    // 范围
    cell.velocityRange = 150;
    // Y轴 加速度分量
    cell.yAcceleration = 75;
    // 生命周期
    cell.lifetime = 2.04;
    // 图片
    cell.contents = (__bridge id)[[UIImage imageNamed:@"FFRing"] CGImage];
    // 缩放比例
    cell.scale = 0.2;
    // 粒子的颜色
    cell.color = [[UIColor colorWithRed:0.6
                                  green:0.6
                                   blue:0.6
                                  alpha:1.0] CGColor];
    // 颜色改变范围
    cell.greenRange = 1.0;
    cell.redRange = 1.0;
    cell.blueRange = 1.0;
    // 粒子旋转角度范围
    cell.spinRange = M_PI;
    
    // 爆炸
    CAEmitterCell *burst = [CAEmitterCell emitterCell];
    // 每秒创建的发射对象的数量
    burst.birthRate = 1.0;
    // 速度
    burst.velocity = 0;
    // 缩放比例
    burst.scale = 2.5;
    // 颜色改变速度
    burst.redSpeed = -1.5;
    burst.blueSpeed = +1.5;
    burst.greenSpeed = +1.0;
    // 生命周期
    burst.lifetime = 0.35;
    
    // 火花
    CAEmitterCell *spark = [CAEmitterCell emitterCell];
    // 粒子产生系数,默认为1.0
    spark.birthRate = 400;
    // 速度
    spark.velocity = 125;
    // 发射的角度
    spark.emissionRange = 2 * M_PI;
    // y方向上的加速度分量
    spark.yAcceleration = 75;
    // 粒子声明周期
    spark.lifetime = 3;
    // 图片
    spark.contents = (__bridge id)[[UIImage imageNamed:@"FFTspark"] CGImage];
    // 缩放比例速度
    spark.scaleSpeed = -0.2;
    // 颜色改变速度
    spark.greenSpeed = -0.1;
    spark.redSpeed = 0.4;
    spark.blueSpeed = -0.1;
    // 粒子透明度在声明周期内的改变速度
    spark.alphaSpeed = -0.25;
    // 子旋转角度
    spark.spin = 2 * M_PI;
    // 子旋转角度范围
    spark.spinRange = 2 * M_PI;
    
    self.caElayer.emitterCells = [NSArray arrayWithObject:cell];// emitterCells 发射器单元的阵列附接到层。每个对象必须具有CAEmitterCell类。
    cell.emitterCells = [NSArray arrayWithObjects:burst, nil];// emitterCells 包含此单元格的子单元格的数组，或nil（默认值）。当非零时，由单元发射的每个粒子将用作每个单元的子单元的发射器。发射点是当前粒子位置，发射角度相对于粒子的当前方向。
    burst.emitterCells = [NSArray arrayWithObject:spark];
    [self.view.layer addSublayer:self.caElayer];
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
