//
//  ViewController.m
//  CAEmitterLayer
//
//  Created by 薛尧 on 2016/12/8.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    /**
     官方文档解释:
     
     在iOS 5中，苹果引入了一个新的CALayer子类叫做CAEmitterLayer。CAEmitterLayer是一个高性能的粒子引擎，被用来创建实时例子动画如：烟雾，火，雨等等这些效果。
     CAEmitterLayer看上去像是许多CAEmitterCell的容器，这些CAEmitierCell定义了一个例子效果。你将会为不同的例子效果定义一个或多个CAEmitterCell作为模版，同时CAEmitterLayer负责基于这些模版实例化一个粒子流。一个CAEmitterCell类似于一个CALayer：它有一个contents属性可以定义为一个CGImage，另外还有一些可设置属性控制着表现和行为。我们不会对这些属性逐一进行详细的描述，你们可以在CAEmitterCell类的头文件中找到。
     */
    
    [self bigBang];
}

- (void)bigBang
{
    // 创建粒子发射器层
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    // 配置发射器
    emitter.renderMode = kCAEmitterLayerAdditive;// 一个字符串,定义如何将粒子合成到图层的图像中
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);// 发射形状的中心,默认为(0, 0 ,0),隐式动画.
    
    // 创建一个粒子模板
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"圆角六角星"].CGImage;
    cell.birthRate = 150;// 每秒创建的发射对象的数量,默认为零,隐式动画.
    cell.lifetime = 5.0;// 每个发射对象的生命周期(以秒为单位),指定为平均值和平均值范围.这两个值默认为零.
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;// 每个发射对象的平均颜色，以及从该平均颜色的范围。 `color'默认为不透明白色，`colorRange'为（0，0，0，0）。隐式动画。
    cell.alphaSpeed = -0.4;// 发射对象的颜色分量在其寿命期间的变化速度，定义为每秒的变化率。默认为（0，0，0，0）。隐式动画。
    cell.velocity = 50;// 每个发射对象的初始平均速度。默认为零。隐式动画。
    cell.velocityRange = 50;// 每个发射对象的初始平均速度范围。默认为零。隐式动画。
    cell.emissionRange = M_PI * 2.0;// 围绕发射角限定锥体的角度（以弧度表示）。所有物体均匀地分布在该锥体上。默认为零。隐式动画。
    
    // 添加粒子模板到发射器
    emitter.emitterCells = @[cell];
    
    
    /**
     CAEMitterCell的属性基本上可以分为三种：
        1.这种粒子的某一属性的初始值。比如，color属性指定了一个可以混合图片内容颜色的混合色。在示例中，我们将它设置为桔色。
        2.例子某一属性的变化范围。比如emissionRange属性的值是2π，这意味着例子可以从360度任意位置反射出来。如果指定一个小一些的值，就可以创造出一个圆锥形
        3.指定值在时间线上的变化。比如，在示例中，我们将alphaSpeed设置为-0.4，就是说例子的透明度每过一秒就是减少0.4，这样就有发射出去之后逐渐小时的效果。
     
     
     CAEmitterLayer的属性它自己控制着整个粒子系统的位置和形状。一些属性比如birthRate，lifetime和celocity，这些属性在CAEmitterCell中也有。这些属性会以相乘的方式作用在一起，这样你就可以用一个值来加速或者扩大整个例子系统。其他值得提到的属性有以下这些：
        1.preservesDepth，是否将3D例子系统平面化到一个图层（默认值）或者可以在3D空间中混合其他的图层
        2.renderMode，控制着在视觉上粒子图片是如何混合的。你可能已经注意到了示例中我们把它设置为kCAEmitterLayerAdditive，它实现了这样一个效果：合并例子重叠部分的亮度使得看上去更亮。如果我们把它设置为默认的kCAEmitterLayerUnordered，效果就没那么好看了
     */
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
