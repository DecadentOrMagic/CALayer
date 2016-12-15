//
//  ViewController.m
//  EmitterSnowDemo
//
//  Created by 薛尧 on 2016/12/15.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self snow];
}

#pragma mark - 雪花
- (void)snow
{
    self.view.backgroundColor = [UIColor blackColor];
    
    // 创建粒子layer
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    // 粒子发射位置
    snowEmitter.emitterPosition = CGPointMake(120, 0);
    // 发射源的尺寸大小(发射形状的大小。默认为（0，0，0）。动画。根据`emitShape'属性，一些值可能会被忽略。)
    snowEmitter.emitterSize = self.view.bounds.size;
    // 发射模式
    snowEmitter.emitterMode = kCAEmitterLayerSurface;// 表面
    // 发射源的形状
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    
    // 创建雪花类型的粒子
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    // 粒子的名字
    snowflake.name = @"snow";
    // 每秒创建的发射对象的数量
    snowflake.birthRate = 20.0;
    // 每个发射对象的生命周期
    snowflake.lifetime = 120.0;
    // 粒子的速度
    snowflake.velocity = 10.0;
    // 离子的速度范围
    snowflake.velocityRange = 10;
    // 粒子y方向加速度分量
    snowflake.yAcceleration = 2;
    // 周围发射角度
    snowflake.emissionRange = 0.5 * M_PI;// 围绕发射角定义圆锥的角度(以弧度表示).发射的物体均匀分布在该椎体上
    // 子旋转角度角度范围
    snowflake.spinRange = 0.25 * M_PI;// 应用于每个发射对象的旋转速度平均值的范围
    snowflake.contents  = (id)[[UIImage imageNamed:@"snow"] CGImage];
    // 设置雪花形状的粒子的颜色
    snowflake.color = [[UIColor whiteColor] CGColor];
    snowflake.redRange = 1.5f;
    snowflake.greenRange = 2.2f;
    snowflake.blueRange = 2.2f;
    
    snowflake.scaleRange = 0.6f;
    snowflake.scale = 0.7f;
    
    snowEmitter.shadowOpacity = 1.0;
    snowEmitter.shadowRadius = 0.0;
    snowEmitter.shadowOffset = CGSizeMake(0.0, 0.0);
    
    // 粒子边缘的颜色
    snowEmitter.shadowColor  = [[UIColor whiteColor] CGColor];
    // 添加粒子
    snowEmitter.emitterCells = @[snowflake];
    // 将粒子Layer添加进图层中
    [self.view.layer addSublayer:snowEmitter];
    
    // 形成遮罩
    UIImage *image = [UIImage imageNamed:@"alpha"];
    _layer = [CALayer layer];
    _layer.frame = (CGRect){CGPointZero, self.view.bounds.size};
    _layer.contents = (__bridge id)(image.CGImage);
    _layer.position = self.view.center;
    snowEmitter.mask = _layer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
