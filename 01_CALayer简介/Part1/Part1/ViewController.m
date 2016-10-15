//
//  ViewController.m
//  Part1
//
//  Created by 薛尧 on 16/8/16.
//  Copyright © 2016年 Dom. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView      *customView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // http://www.cnblogs.com/wendingding/p/3800010.html
    
    /**
     *  简单介绍
     *
     *  在iOS中，你能看得见摸得着的东西基本上都是UIView，比如一个按钮、一个文本标签、一个文本输入框、一个图标等等，这些都是UIView。
     *  其实UIView之所以能显示在屏幕上，完全是因为它内部的一个图层，在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，通过UIView的layer属性可以访问这个层：
         @property(nonatomic,readonly,retain) CALayer *layer;
     *  当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，于是就完成了UIView的显示
     *  换句话说，UIView本身不具备显示的功能，拥有显示功能的是它内部的图层。
     */
    
    
    // UIView之所以能够显示，完全是因为内部的CALayer对象。因此，通过操作这个CALayer对象，可以很方便地调整UIView的一些界面属性，比如：阴影、圆角大小、边框宽度和颜色等。
    // 注意：layer中不能直接接受UI框架中的东西
    
    
    // 通过 layer 设置边框的宽度和颜色
//    [self setWidthAndColor];
    
    // 通过layer设置边框为圆角
//    [self setCornerRadius];
    
    // 在layer上添加一张图片
//    [self addImage];
    
    // 设置超过子图层的部分裁减掉
//    [self setCut];
    
    // 设置阴影
//    [self setShadow];
    
    // 以上代码完整演示
//    [self completeDemo];
    
    // 只要是继承自 UIView 的都有layer属性
    [self configImageView];
}


#pragma mark - 通过 layer 设置边框的宽度和颜色
- (void)setWidthAndColor
{
    // 设置边框的宽度为20
    self.customView.layer.borderWidth = 5;
    // 设置边框的颜色
    self.customView.layer.borderColor = [UIColor blackColor].CGColor;
}

#pragma mark - 通过layer设置边框为圆角
- (void)setCornerRadius
{
    // 设置边框的宽度为20
    self.customView.layer.borderWidth = 5;
    // 设置边框的颜色
    self.customView.layer.borderColor = [UIColor blackColor].CGColor;
    // 设置layer的圆角
    self.customView.layer.cornerRadius = 20;
}

#pragma mark - 在layer上添加一张图片
- (void)addImage
{
    // 设置边框的宽度为20
    self.customView.layer.borderWidth = 5;
    // 设置边框的颜色
    self.customView.layer.borderColor = [UIColor blackColor].CGColor;
    // 设置layer的圆角
    self.customView.layer.cornerRadius = 20;
    // 在view的图层上添加一个image，contents表示接受内容
    // contents是id类型，可以接受内容，下面的实例让layer显示一张图片
    self.customView.layer.contents = (id)[UIImage imageNamed:@"AI_200*200"].CGImage;
}

#pragma mark - 设置超过子图层的部分裁减掉
- (void)setCut
{
    // 设置边框的宽度为20
    self.customView.layer.borderWidth = 5;
    // 设置边框的颜色
    self.customView.layer.borderColor = [UIColor blackColor].CGColor;
    // 设置layer的圆角
    self.customView.layer.cornerRadius = 20;
    
    // 设置超出子视图的部分裁减掉
    // UI框架中使用的方法
    //    self.customView.clipsToBounds = YES;
    self.customView.layer.masksToBounds = YES;//建议使用这一种
    
    // 在view的图层上添加一个image，contents表示接受内容
    // contents是id类型，可以接受内容，下面的实例让layer显示一张图片
    self.customView.layer.contents = (id)[UIImage imageNamed:@"AI_200*200"].CGImage;
}

#pragma mark - 设置阴影
- (void)setShadow
{
    /**
     *  设置阴影，不光需要设置阴影颜色，还应该设置阴影的偏移位和透明度。
     *  因为如果不设置偏移位的话，那么阴影和layer完全重叠，且默认透明度为0（即完全透明）。
     */
    
    // 注意：如果设置了超过主图层的部分减掉，则设置阴影不会有显示效果。
    
    // 设置阴影颜色
    self.customView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的偏移量，如果为正数，则代表为往右下偏移
    self.customView.layer.shadowOffset = CGSizeMake(15, 5);
    // 设置阴影的透明度(0~1之间，0表示完全透明)
    self.customView.layer.shadowOpacity = 0.6;
}

#pragma mark - 以上代码完整演示
- (void)completeDemo
{
    // 设置边框的宽度为20
    self.customView.layer.borderWidth = 5;
    // 设置边框的颜色
    self.customView.layer.borderColor = [UIColor blackColor].CGColor;
    // 设置layer的圆角
    self.customView.layer.cornerRadius = 20;
    
    // 设置超出子视图的部分裁减掉
    // UI框架中使用的方法
    //    self.customView.clipsToBounds = YES;
//    self.customView.layer.masksToBounds = YES;//建议使用这一种
    
    // 在view的图层上添加一个image，contents表示接受内容
    // contents是id类型，可以接受内容，下面的实例让layer显示一张图片
    self.customView.layer.contents = (id)[UIImage imageNamed:@"AI_200*200"].CGImage;
    
    // 设置阴影颜色
    self.customView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影的偏移量，如果为正数，则代表为往右下偏移
    self.customView.layer.shadowOffset = CGSizeMake(15, 5);
    // 设置阴影的透明度(0~1之间，0表示完全透明)
    self.customView.layer.shadowOpacity = 0.6;
}

#pragma mark - 只要是继承自 UIView 的都有layer属性
- (void)configImageView
{
    // 设置layer的边框宽度和颜色
    self.iconView.layer.borderColor = [UIColor brownColor].CGColor;
    self.iconView.layer.borderWidth = 5;
    
    // 设置layer圆角
    self.iconView.layer.cornerRadius = 20;
    // 设置超过子图层的部分裁减掉
    self.iconView.layer.masksToBounds = YES;
}

#pragma mark - 设置图片的形变属性(transform)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self setTransform];
//    [self setTransformByKVC];
    [self setRotation];
}

#pragma mark - 形变属性
- (void)setTransform
{
    // 通过UIView来设置（2D效果）
    //    self.iconView.transform = CGAffineTransformMakeTranslation(0, -100);
    // 通过layer来设置(3D效果，x，y，z三个方向)
    self.iconView.layer.transform = CATransform3DMakeTranslation(100, 20, 0);
}

#pragma mark - 通过KVC来设置形变
- (void)setTransformByKVC
{
    // 通过KVC来设置
    NSValue *v = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 20, 0)];
    [self.iconView.layer setValue:v forKey:@"transform"];
    // 如果只需要设置在某一个方向上的移动，可以参考下面代码
    // 在x方向上向左移动100
//    [self.iconView.layer setValue:@(-100) forKey:@"transform.translation.x"];
}

#pragma mark - 旋转
- (void)setRotation
{
    // 旋转
    self.iconView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 0.5);
}
























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
