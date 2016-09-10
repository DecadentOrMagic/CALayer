//
//  ViewController.m
//  Part6
//
//  Created by 薛尧 on 16/9/1.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *loadingLayer;
@property (nonatomic, strong) NSTimer      *timer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  CAShapeLayer继承自CALayer，因此，可使用CALayer的所有属性。但是，CAShapeLayer需要和贝塞尔曲线配合使用才有意义。
     *  它有一个path属性，而UIBezierPath就是对CGPathRef类型的封装，因此这两者配合起来使用才可以
     *
     *
     *  与drawRect比较
     *  drawRect：属于CoreGraphics框架，占用CPU，性能消耗大，不建议重写
     *  CAShapeLayer：属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存
     *  这两者各有各的用途，而不是说有了CAShapeLayer就不需要drawRect
     *
     *
     *  CAShapeLayer与UIBezierPath的关系：
     *  1、CAShapeLayer中shape代表形状的意思，所以需要形状才能生效
     *  2、贝塞尔曲线可以创建基于矢量的路径，而UIBezierPath类是对CGPathRef的封装
     *  3、贝塞尔曲线给CAShapeLayer提供路径，CAShapeLayer在提供的路径中进行渲染。路径会闭环，所以绘制出了Shape
     *  4、用于CAShapeLayer的贝塞尔曲线作为path，其path是一个首尾相接的闭环的曲线，即使该贝塞尔曲线不是一个闭环的曲线
     */
}



//----------------------------------------------------------------//
//---------------- 画圆的方法 -------------------//

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.画圆的方法
//    [self drawCircle];
}


#pragma mark - 1.画圆的方法
- (void)drawCircle
{
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    // 指定frame,只是为了设置高度和宽度
    circleLayer.frame = CGRectMake(0, 0, 200, 200);
    // 设置居中显示
    circleLayer.position = self.view.center;
    // 设置填充颜色
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    // 设置线宽
    circleLayer.lineWidth = 2.0;
    // 设置线的颜色
    circleLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 使用UIBezierPath创建路径
    CGRect frame = CGRectMake(0, 0, 200, 200);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    // 设置CAShapeLayer与UIBezierPath关联
    circleLayer.path = circlePath.CGPath;
    
    // 将CAShaperLayer放到某个层上显示
    [self.view.layer addSublayer:circleLayer];
    
    /**
     *  注意，我们这里不是放在-drawRect:方法中调用的。我们直接将这个CAShaperLayer放到了self.view.layer上，直接呈现出来。
     *
     *  我们创建一个CAShapeLayer，然后配置相关属性，然后再通过UIBezierPath的类方法创建一个内切圆路径，然后将路径指定给CAShapeLayer.path，这就将两者关联起来了。最后，将这个层放到了self.view.layer上呈现出来。
     */
}



#pragma mark - 点击开始按钮
- (IBAction)startBtnDidClicked:(id)sender {
    [self drawHalfCircle];
}

- (void)drawHalfCircle
{
    self.loadingLayer = [CAShapeLayer layer];
    // 指定frame,只是为了设置高度和宽度
    self.loadingLayer.frame = CGRectMake(0, 0, 200, 200);
    // 设置居中显示
    self.loadingLayer.position = self.view.center;
    // 设置填充颜色
    self.loadingLayer.fillColor = [UIColor clearColor].CGColor;
    // 设置线宽
    self.loadingLayer.lineWidth = 2.0;
    // 设置线的颜色
    self.loadingLayer.strokeColor = [UIColor redColor].CGColor;
    
    // 使用UIBezierPath创建路径
    CGRect frame = CGRectMake(0, 0, 200, 200);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    // 设置CAShapeLayer与UIBezierPath关联
    self.loadingLayer.path = circlePath.CGPath;
    
    // 将CAShaperLayer放到某个层上显示
    [self.view.layer addSublayer:self.loadingLayer];
    
    
    // 这个是用于指定画笔的开始与结束点
    self.loadingLayer.strokeStart = 0.0;
    self.loadingLayer.strokeEnd = 0.5;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateCircle) userInfo:nil repeats:YES];
}

- (void)updateCircle
{
    if (self.loadingLayer.strokeEnd > 1 && self.loadingLayer.strokeStart < 1) {
        self.loadingLayer.strokeStart += 0.1;
    }
    else if (self.loadingLayer.strokeStart == 0) {
        self.loadingLayer.strokeEnd += 0.1;
    }
    
    if (self.loadingLayer.strokeEnd == 0) {
        self.loadingLayer.strokeStart = 0;
    }
    
    if (self.loadingLayer.strokeStart >= 1 && self.loadingLayer.strokeEnd >= 1) {
        self.loadingLayer.strokeStart = 0;
        [self.timer invalidate];
        self.timer = nil;
    }
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
