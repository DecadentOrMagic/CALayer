//
//  ViewController.m
//  Part2
//
//  Created by 薛尧 on 16/8/17.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /**
     *  创建图层的步骤
     *  1.创建layer
     *  2.设置layer的属性（设置了颜色，bounds才能显示出来）
     *  3.将layer添加到界面上（控制器view的layer上）
     */
    
    /**
     *  补充一
     *  为什么CALayer中使用CGColorRef和CGImageRef这2种数据类型，而不用UIColor和UIImage？
     *  首先要知道：CALayer是定义在QuartzCore框架中的；CGImageRef、CGColorRef两种数据类型是定义在CoreGraphics框架中的；UIColor、UIImage是定义在UIKit框架中的
     *  其次，QuartzCore框架和CoreGraphics框架是可以跨平台使用的，在iOS和Mac OS X上都能使用，但是UIKit只能在iOS中使用
     *  因此，为了保证可移植性，QuartzCore不能使用UIImage、UIColor，只能使用CGImageRef、CGColorRef
     *  不过很多情况下，可以通过UIKit对象的特定方法，得到CoreGraphics对象，比如UIImage的CGImage方法可以返回一个CGImageRef
     */
    
    /**
     *  补充二
     *  其实前面的2个效果不仅可以通过添加层来实现，还可以通过添加UIView来实现。比如，第1个红色的层可以用一个UIView来实现，第2个显示图片的层可以用一个UIImageView来实现。 既然CALayer和UIView都能实现相同的显示效果，那究竟该选择谁好呢？
     *  其实，对比CALayer，UIView多了一个事件处理的功能。也就是说，CALayer不能处理用户的触摸事件，而UIView可以
     *  所以，如果显示出来的东西需要跟用户进行交互的话，用UIView；如果不需要跟用户进行交互，用UIView或者CALayer都可以
     *  当然，CALayer的性能会高一些，因为它少了事件处理的功能，更加轻量级
     */
    
    
    // UIView内部默认有个CALayer对象(层)，通过layer属性可以访问这个层。要注意的是，这个默认的层不允许重新创建，但可以往层里面添加子层
    // UIView可以通过addSubview:方法添加子视图，类似地，CALayer可以通过addSublayer:方法添加子层
    
    
    
    // 添加一个简单的图层
//    [self createSimpleLayer];
    // 添加一个显示图片的图层
//    [self createPictureLayer];
    // 访问层
//    [self visitLayer];
    // 子控件的layer
    [self subViewLayer];
}

#pragma mark - 添加一个简单的图层
- (void)createSimpleLayer
{
    // 1.创建一个layer
    // 使用对象方法创建
//    CALayer *layer = [[CALayer alloc] init];
    // 使用类方法创建
    CALayer *layer = [CALayer layer];
    
    // 2.设置layer的属性(一定要设置位置,颜色属性才能显示出来)
    // 设置层的宽度和高度（100x100）
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 设置层的位置
    layer.position = CGPointMake(100, 100);
    // 设置层的背景颜色：红色
    layer.backgroundColor = [UIColor redColor].CGColor;
    // 设置层的圆角半径为10
    layer.cornerRadius = 10;
    // 添加layer到控制器的view的layer中
    [self.view.layer addSublayer:layer];
}

#pragma mark - 添加一个显示图片的图层
- (void)createPictureLayer
{
    NSLog(@"start---%@",self.view.layer.sublayers);
    CALayer *layer = [CALayer layer];
    // 设置层的宽度和高度（100x100）
    layer.bounds = CGRectMake(0, 0, 100, 100);
    // 设置层的位置
    layer.position = CGPointMake(100, 100);
    // 设置需要显示的图片
    layer.contents = (id)[UIImage imageNamed:@"AI_200*200"].CGImage;// 这里用的是UIImage的CGImage属性，是一种CGImageRef类型的数据
    // 设置层的圆角半径为10
    layer.cornerRadius = 10;
    // 如果设置了图片，需要设置这个属性为YES才有圆角效果(不设置也有)
    layer.masksToBounds = YES;
    // 添加layer到控制器的view的layer中
    [self.view.layer addSublayer:layer];
    NSLog(@"end---%@",self.view.layer.sublayers);// 在添加layer之前，控制器view上layer又两个子layer，添加之后，有三个子layer。
}

#pragma mark - 访问层
- (void)visitLayer
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor brownColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(100, 100);
    [self.view.layer addSublayer:layer];
    
    // CALayer通过sublayers属性访问所有的子层
    // UIView可以通过subviews属性访问所有的子视图，类似地，CALayer也可以通过sublayers属性访问所有的子层
    NSLog(@"%@",self.view.layer.sublayers[2]);
    NSLog(@"%@",layer);
    
    // CALayer也可以通过superlayer属性访问父层
    // UIView可以通过superview属性访问父视图，类似地，CALayer也可以通过superlayer属性访问父层
    NSLog(@"%@",layer.superlayer);
    NSLog(@"%@",self.view.layer);
}

#pragma mark - 子控件的layer
- (void)subViewLayer
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    label.backgroundColor = [UIColor blueColor];
    [self.view addSubview:label];
    // 特别注意：如果一个控件是另外一个控件的子控件，那么这个控件的layer也是另一个控件的子layer
    NSLog(@"%@",self.view.layer.sublayers);
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
