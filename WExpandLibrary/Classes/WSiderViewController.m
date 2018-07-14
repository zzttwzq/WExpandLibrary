//
//  WSiderViewController.m
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/4.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WSiderViewController.h"

@interface WSiderViewController ()

@end

@implementation WSiderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    

    //1.添加子控制器
    [self addChildViewController:_leftVC];
    [self addChildViewController:_rightVC];
    [self addChildViewController:_mainVC];


    //2.添加view
    [self.view addSubview:_leftVC.view];
    _leftVC.view.alpha = 0;

    [self.view addSubview:_rightVC.view];
    _rightVC.view.alpha = 0;

    [self.view addSubview:_mainVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
