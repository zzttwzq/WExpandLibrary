//
//  WNavViewController.m
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/3.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WNavViewController.h"

@interface WNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WNavViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.interactivePopGestureRecognizer.delegate = self;
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

+ (void)initialize
{
    [self setupNavigationBarTheme];
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];


    // 2.设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];//[UIColor colorWithRed:149/255.0 green:68/255.0 blue:83/255.0 alpha:1.0];
    // UITextAttributeFont  --> NSFontAttributeName(iOS7)
    //#warning 过期 : 并不代表不能用, 仅仅是有最新的方案可以取代它
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:17];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    CGSize shadowOffset = CGSizeZero;
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = shadowOffset;
    textAttrs[NSShadowAttributeName] = shadow;
    [appearance setTitleTextAttributes:textAttrs];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.viewControllers.count > 0){
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"back" highImageName:@"back" target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count > 1;
}

@end
