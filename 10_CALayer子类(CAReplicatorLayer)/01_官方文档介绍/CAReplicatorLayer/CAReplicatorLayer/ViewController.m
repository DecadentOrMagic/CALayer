//
//  ViewController.m
//  CAReplicatorLayer
//
//  Created by 薛尧 on 2016/12/9.
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
     CAReplicatorLayer(replicator复制器)
        CAReplicatorLayer的目的是为了高效生成许多相似的图层。它会绘制一个或多个图层的子图层，并在每个复制体上应用不同的变换。
     */
    
    [self useReplicatorLayer];
}

- (void)useReplicatorLayer
{
    // 创建一个复制器图层并添加到view上
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    // 配置复制器图层
    replicator.instanceCount = 10;// 指定图层需要创建多少次,包括源图层
    
    // 对每个应用实例进行转换
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 30.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;// instanceTransform指定了一个CATransform3D变换（这种情况下，下一图层的位移和旋转将会移动到圆圈的下一个点）。
    
    // 对每个实例应用颜色偏移
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    // 创建子层并将其放置在复制器图层中
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 100, 100, 100);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
    /**
     注意到当图层在重复的时候，他们的颜色也在变化：这是用instanceBlueOffset和instanceGreenOffset属性实现的。通过逐步减少蓝色和绿色通道，我们逐渐将图层颜色转换成了红色。
     这个复制效果看起来很酷，但是CAReplicatorLayer真正应用到实际程序上的场景比如：一个游戏中导弹的轨迹云，或者粒子爆炸（尽管iOS 5已经引入了CAEmitterLayer，它更适合创建任意的粒子效果）。除此之外，还有一个实际应用是：反射。
     */
}





















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
