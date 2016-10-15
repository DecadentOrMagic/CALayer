//
//  ViewController.m
//  Part7
//
//  Created by 薛尧 on 16/9/21.
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
    
    // https://zsisme.gitbooks.io/ios-/content/chapter6/cagradientLayer.html
    
    // CAGradientLayer是用来生成两种或更多颜色平滑渐变的.
//    [self basicGradient];
    
    // 多重渐变
    [self multipleGradient];
}


#pragma mark - 基础渐变
// 用CAGradientLayer实现简单的两种颜色的对角线渐变
- (void)basicGradient
{
    // 创建梯度layer
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    // 设置梯度颜色
    // 我们将从一个简单的红变蓝的对角线渐变开始（见清单6.6）.这些渐变色彩放在一个数组中，并赋给colors属性。这个数组成员接受CGColorRef类型的值（并不是从NSObject派生而来），所以我们要用通过bridge转换以确保编译正常。
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    // 设置梯度的起点和终点
    // @property CGPoint startPoint 映射locations中第一个位置，用单位向量表示，比如（0，0）表示从左上角开始变化。默认值是(0.5,0.0)
    gradientLayer.startPoint = CGPointMake(0, 0);
    // @property CGPoint endPoint 映射locations中最后一个位置，用单位向量表示，比如（1，1）表示到右下角变化结束。默认值是(0.5,1.0)
    gradientLayer.endPoint = CGPointMake(1, 1);
    
    // @property(copy) NSString *type 默认值是kCAGradientLayerAxial，表示按像素均匀变化。除了默认值也无其它选项
    gradientLayer.type = kCAGradientLayerAxial;
}


#pragma mark - 多重渐变
- (void)multipleGradient
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor];
    
    // 设置location属性
    // 可以用locations属性来调整空间。locations属性是一个浮点数值的数组（以NSNumber包装）。这些浮点数定义了colors属性中每个不同颜色的位置，同样的，也是以单位坐标系进行标定
    // locations数组并不是强制要求的，但是如果你给它赋值了就一定要确保locations的数组大小和colors数组大小一定要相同，否则你将会得到一个空白的渐变。
//    gradientLayer.locations = @[@0.0, @0.5, @1.0];// 表示从0.0为红色,0.5为黄色,1为绿色,整个梯度颜色一直在渐变
    gradientLayer.locations = @[@0.25, @0.5, @1.0];// 表示0.0-0.25都是红色,0.25到0.5渐变成黄色,0.5这条线是黄色,0.5-1.0渐变为绿色,1.0这条线是绿色.
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
