//
//  ViewController.m
//  Part4
//
//  Created by 薛尧 on 16/8/22.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

#import "XYLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 以前想要在view中画东西，需要自定义view,创建一个类与之关联，让这个类继承自UIView，然后重写它的DrawRect：方法，然后在该方法中画图
    [self first];
    
    // 调用second方法前,先把XYLayer.m里的代码注释掉
    [self second];
}

#pragma mark - 第一种方式
- (void)first
{
    /**
     *  注意点：
     *  默认为无色，不会显示。要想让绘制的图形显示出来，还需要设置图形的颜色。注意不能直接使用UI框架中的类
     *  在自定义layer中的-(void)drawInContext:方法不会自己调用，只能自己通过setNeedDisplay方法调用，在view中画东西DrawRect:方法在view第一次显示的时候会自动调用。
     */
    /**
     *  在UIView中绘制图形，获取的上下文就是这个view对应的layer的上下文。在渲染的时候，就是把图形渲染到对应的layer上。在执行渲染操作的时候，本质上它的内部相当于执行了 [self.layer drawInContext:ctx];
     */
    // 1.创建自定义的layer
    XYLayer *layer = [XYLayer layer];
    // 2.设置layer的属性
    layer.backgroundColor = [UIColor brownColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 200, 150);
    layer.anchorPoint = CGPointZero;
    layer.position = CGPointMake(100, 100);
    layer.cornerRadius = 20;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(10, 20);
    layer.shadowOpacity = 0.6;
    
    [layer setNeedsDisplay];
    [self.view.layer addSublayer:layer];
}

#pragma mark - 第二种方式
- (void)second
{
    /**
     *  不能再将某个UIView设置为CALayer的delegate，因为UIView对象已经是它内部根层的delegate，再次设置为其他层的delegate就会出问题。
     *  在设置代理的时候，它并不要求我们遵守协议，说明这个方法是nsobject中的，就不需要再额外的显示遵守协议了。
     *  以后如果要设置某个类的代理，但是这个代理没要求我们遵守什么特定的协议，那么可以认为这个协议方法是NSObject里边的。
     */
    // 1.创建自定义的layer
    XYLayer *layer = [XYLayer layer];
    // 2.设置layer的属性
    layer.backgroundColor = [UIColor brownColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 200, 150);
    layer.anchorPoint = CGPointZero;
    layer.position = CGPointMake(100, 100);
    layer.cornerRadius = 20;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(10, 20);
    layer.shadowOpacity = 0.6;
    
    // 设置代理
    layer.delegate = self;
    [layer setNeedsDisplay];
    // 3.添加layer
    [self.view.layer addSublayer:layer];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    // 1.绘制图形
    // 画一个圆
    CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
    // 设置属性(颜色)
    CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
    // 2.渲染
    CGContextFillPath(ctx);
}

/**
 *  补充说明
 *  无论采取哪种方法来自定义层，都必须调用CALayer的setNeedsDisplay方法才能正常绘图。
 *  详细现实过程：
        当UIView需要显示时，它内部的层会准备好一个CGContextRef(图形上下文)，然后调用delegate(这里就是UIView)的drawLayer:inContext:方法，并且传入已经准备好的CGContextRef对象。而UIView在drawLayer:inContext:方法中又会调用自己的drawRect:方法。平时在drawRect:中通过UIGraphicsGetCurrentContext()获取的就是由层传入的CGContextRef对象，在drawRect:中完成的所有绘图都会填入层的CGContextRef中，然后被拷贝至屏幕。
 */



















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
