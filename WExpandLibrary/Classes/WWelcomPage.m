//
//  WWelcomPage.m
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/4.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WWelcomPage.h"
#import "UIImageView+WebCache.h"

@interface WWelcomPage ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIPageControl *pageCotroll;

@end

@implementation WWelcomPage
/**
 初始化方法（会自动判断是否是url或者是图片格式）

 @param images 图片数组
 @param enablePageControl 是否开启pagectroll
 @return 返回新建的实例
 */
-(instancetype)initWithImages:(NSArray *)images
            enablePageControl:(BOOL)enablePageControl;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor whiteColor];
        self.opaque = YES;
        self.userInteractionEnabled = YES;

        _scroll = [[UIScrollView alloc] initWithFrame:self.frame];
        _scroll.pagingEnabled = YES;
        _scroll.delegate = self;
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.showsVerticalScrollIndicator = NO;
        _scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scroll];

        //是否开启page
        if (enablePageControl) {

            _pageCotroll = [[UIPageControl alloc] initWithFrame:CGRectMake(0, ScreenHeight-64-50, ScreenWidth, 30)];
            [self addSubview:_pageCotroll];
        }

        if (images.count > 0) {

            [self setPage:images];
        }else{

            WLOG(@"WWelcomPage:>>没有任何内容可以显示！！！")
            [self dismiss];
        }
    }

    return self;
}


/**
 设置页面

 @param array 要显示的图片数组
 */
-(void)setPage:(NSArray *)array
{
    //1.设置总的
    _scroll.contentSize = CGSizeMake(ScreenWidth*array.count, ScreenHeight-64);
    _pageCotroll.numberOfPages = array.count;

    for (int i = 0; i<array.count; i++) {

        NSString *item = array[i];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image];

        if ([item containsString:@"http"]) {

            [image sd_setImageWithURL:[NSURL URLWithString:item] placeholderImage:[UIImage imageNamed:PLACEHOLDER_IMG]];
        }else{

            NSString *path = [WFileManager getFilePathWithFileName:item];
            image.image = [UIImage imageWithContentsOfFile:path];
        }
        [_scroll addSubview:image];

        if (i == array.count - 1) {

            image.userInteractionEnabled = YES;
            [image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
        }
    }
}


-(void)click
{
    if (self.state) {

        self.state(YES);
    }
    [self dismiss];
}


/**
 取消导航view 
 */
-(void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{

        self.alpha = 0;
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];
}


#pragma mark - 代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/ScreenWidth;
    _pageCotroll.currentPage = page;
}
@end
