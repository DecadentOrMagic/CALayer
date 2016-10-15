//
//  ViewController.m
//  Part8
//
//  Created by 薛尧 on 16/9/27.
//  Copyright © 2016年 薛尧. All rights reserved.
//

#import "ViewController.h"

static const CFTimeInterval duration = 4.0;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIImageView *grayHead;
@property (weak, nonatomic) IBOutlet UIImageView *greenHead;
@property (nonatomic, strong) CAShapeLayer *maskLayerUp;
@property (nonatomic, strong) CAShapeLayer *maskLayerDown;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  mask属性简介
     *
     *  CALayer有一个属性叫做mask,这个属性本身就是个CALayer类型，有和其他图层一样的绘制和布局属性。它类似于一个子图层，相对于父图层（即拥有该属性的图层）布局，但是它却不是一个普通的子图层。不同于那些绘制在父图层中的子图层，mask图层定义了父图层的部分可见区域。
     *  mask图层的Color属性是无关紧要的，真正重要的是图层的轮廓。mask属性就像是一个饼干切割机，mask图层实心的部分会被保留下来，其他的则会被抛弃。
     *  如果mask图层比父图层要小，只有在mask图层里面的内容才是它关心的，除此以外的一切都会被隐藏起来。
     */
    
    // 简单介绍 layer 的 mask 属性
    [self simpleMask];
    
    // 注水效果
    self.greenHead.layer.mask = [self greenHeadMaskLayer];
    [self startGreenHeadAnimation];
}




#pragma mark - 简单介绍 layer 的 mask 属性
- (void)simpleMask
{
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.imageview.bounds;
    UIImage *maskImage = [UIImage imageNamed:@"4.12"];
    maskLayer.contents = (__bridge id)maskImage.CGImage;
    
    self.imageview.layer.mask = maskLayer;
}




#pragma mark - 注水效果
- (CALayer *)greenHeadMaskLayer
{
    CALayer *mask = [CALayer layer];
    mask.frame = self.greenHead.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 30, 30);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor;// 除了clearcolor,其他任何颜色都可以
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15)
                                                           radius:15
                                                       startAngle:0
                                                         endAngle:2 * M_PI
                                                        clockwise:YES].CGPath;
    self.maskLayerUp.opacity = 0.8;
    self.maskLayerUp.position = CGPointMake(-5, -5);
    [mask addSublayer:self.maskLayerUp];
    
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 30, 30);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15, 15)
                                                             radius:15
                                                         startAngle:0
                                                           endAngle:2 * M_PI
                                                          clockwise:YES].CGPath;
    self.maskLayerDown.opacity = 0.8;
    self.maskLayerDown.position = CGPointMake(35, 35);
    [mask addSublayer:self.maskLayerDown];
    
    return mask;
}

- (void)startGreenHeadAnimation
{
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    downAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5, -5)];
    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    downAnimation.duration = duration;
    [self.maskLayerUp addAnimation:downAnimation forKey:@"downAnimation"];
    
    CABasicAnimation *upAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    upAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(35, 35)];
    upAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(20, 20)];
    upAnimation.duration = duration;
    [self.maskLayerDown addAnimation:upAnimation forKey:@"upAnimation"];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
