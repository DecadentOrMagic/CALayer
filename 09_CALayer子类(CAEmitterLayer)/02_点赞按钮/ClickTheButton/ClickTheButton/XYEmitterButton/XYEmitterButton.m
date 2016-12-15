//
//  XYEmitterButton.m
//  ClickTheButton
//
//  Created by 薛尧 on 2016/12/8.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "XYEmitterButton.h"

@interface XYEmitterButton ()

// weak类型 粒子发射器
@property (nonatomic, weak) CAEmitterLayer *emitterLayer;

@end

@implementation XYEmitterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 配置粒子发射器方法
        [self setupEmitter];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    // 开始关键帧动画
    [self keyframeAnimation];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置粒子发射器的锚点
    _emitterLayer.position = self.imageView.center;
}

#pragma mark - 配置粒子发射器方法
- (void)setupEmitter
{
    // 粒子使用CAEmitterCell初始化
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    // 粒子的名字,在设置喷射个数的时候会用到
    emitterCell.name = @"emitterCell";
    // 粒子的生命周期和生命周期范围
    emitterCell.lifetime = 0.7;
    emitterCell.lifetimeRange = 0.3;
    // 粒子的发射速度和速度的范围
    emitterCell.velocity = 30.00;
    emitterCell.velocityRange = 4.00;
    // 粒子的缩放比例和缩放比例的范围
    emitterCell.scale = 0.1;
    emitterCell.scaleRange = 0.02;
    
    // 粒子透明度改变范围
    emitterCell.alphaRange = 0.10;
    // 粒子透明度在生命周期中改变的速度
    emitterCell.alphaSpeed = -1.0;
    // 设置粒子的图片
    emitterCell.contents = (id)[UIImage imageNamed:@"Sparkle3"].CGImage;
    
    // 初始化粒子发射器
    CAEmitterLayer *layer = [CAEmitterLayer layer];
    // 粒子发射器的名称
    layer.name = @"emitterLayer";
    // 粒子发射器的形状
    layer.emitterShape = kCAEmitterLayerCircle;
    // 粒子发射器发射模式
    layer.emitterMode = kCAEmitterLayerOutline;
    // 粒子发射器中的粒子(炮要使用的炮弹)
    layer.emitterCells = @[emitterCell];
    // 定义粒子细胞是如何被呈现到layer中的
    layer.renderMode = kCAEmitterLayerOldestFirst;
    // 不要修剪layer的边界
    layer.masksToBounds = NO;
    // z 轴的相对坐标 设置为-1 可以让粒子发射器layer在self.layer下面
    layer.zPosition = -1;
    // 添加layer
    [self.layer addSublayer:layer];
    _emitterLayer = layer;
    
    /**
     这里有一点需要详细解释一下，CAEmitterCell的属性一般有两个参数：一个平均值和一个“Range”，比如：
         // 粒子的生命周期和生命周期范围
         emitterCell.lifetime         = 0.7;
         emitterCell.lifetimeRange    = 0.3;
     
     
     这里苹果的官方文档是这样解释的:
         每一个Layer都有它自己的随机数发生器,粒子的属性大部分都被定义为一个平均值和一个范围值，
         如粒子的速度，这个属性的值分布的区间为:[ M - R / 2，M + R / 2 ]。
         
         然后 这个公式里面
         M:均值(拿上面代码说就是 emitterCell.lifetime)
         R:范围值(mitterCell.lifetimeRange)
         
         然后我们就可根据公式算出上面我设置的粒子的生命周期的范围是[0.7-0.3/2 , 0.7+0.3/2]
     */
}

#pragma mark - 开始关键帧动画
- (void)keyframeAnimation
{
    // 创建关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected) {
        animation.values = @[@1.5, @0.8, @1.0, @1.2, @1.0];
        animation.duration = 0.5;
        // 粒子发射器 发射
        [self startFire];
    }
    else {
        animation.values = @[@0.8, @1.0];
        animation.duration = 0.4;
    }
    // 动画模式
    animation.calculationMode = kCAAnimationCubic;
    [self.imageView.layer addAnimation:animation forKey:@"transform.scale"];
}

#pragma mark - 开炮
- (void)startFire
{
    // 每秒喷射80个
    [self.emitterLayer setValue:@1000 forKeyPath:@"emitterCells.emitterCell.birthRate"];
    // 开始
    self.emitterLayer.beginTime = CACurrentMediaTime();
    // 执行停止
    [self performSelector:@selector(stopFire) withObject:nil afterDelay:0.1];
}

#pragma mark - 停火
- (void)stopFire
{
    // 每秒喷射的个数0个,就以为着关闭了
    [self.emitterLayer setValue:@0 forKeyPath:@"emitterCells.emitterCell.birthRate"];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
