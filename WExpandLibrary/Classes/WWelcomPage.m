//
//  WWelcomPage.m
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/4.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WWelcomPage.h"
#import "UIImageView+WebCache.h"
#import "WDevice.h"

@interface WWelcomPage ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UIPageControl *pageCotroll;
@property (nonatomic,assign) int totalCount;

@end

@implementation WWelcomPage

/**
 类方法实例化对象 （会自动判断是否是url或者是图片格式）

 @param iphoneImages iphone 图片数组
 @param iphonexImages iphonex 图片数组
 @param enablePageControl 是否显示pagectroll
 */
+ (void) configGuideViewWithIphoneImages:(NSArray *)iphoneImages
                           iphonexImages:(NSArray *)iphonexImages
                       enablePageControl:(BOOL)enablePageControl;
{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"GUIDE_SHOW"];
    if (str.length == 0) {

        if ([WDevice is_Iphone_x]) {
            WWelcomPage *page = [[WWelcomPage alloc] initWithImages:iphonexImages
                                                  enablePageControl:enablePageControl];
            page.contentMode = UIViewContentModeScaleAspectFill;
            [[UIApplication sharedApplication].keyWindow addSubview:page];
        }
        else{

            WWelcomPage *page = [[WWelcomPage alloc] initWithImages:iphoneImages
                                                  enablePageControl:enablePageControl];
            page.contentMode = UIViewContentModeScaleAspectFill;
            [[UIApplication sharedApplication].keyWindow addSubview:page];
        }
    }
}


/**
 初始化方法（会自动判断是否是url或者是图片格式）

 @param images 图片数组
 @param enablePageControl 是否显示pagectroll
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
    _totalCount = (int)array.count;

    for (int i = 0; i<array.count; i++) {

        NSString *item = array[i];
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        image.tag = 1000+i;
        [self addSubview:image];

        if ([item containsString:@"http"]) {

            [image sd_setImageWithURL:[NSURL URLWithString:item]];
        }
        else if ([item containsString:@"jpg"]) {

            NSString *path = [WFileManager getFilePathWithFileName:item];
            image.image = [UIImage imageWithContentsOfFile:path];
        }
        else{

            image.image = [UIImage imageNamed:item];
        }
        [_scroll addSubview:image];

        if (i == array.count - 1) {

            image.userInteractionEnabled = YES;
            [image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
        }
    }

    if (!_comfirmBtn) {
        _comfirmBtn = LABEL_WITH_RECT((array.count-1)*ScreenWidth+30, ScreenHeight-80, ScreenWidth-60, 45);
        _comfirmBtn.layer.cornerRadius = 5;
        _comfirmBtn.layer.masksToBounds = YES;
        _comfirmBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _comfirmBtn.layer.borderWidth = 0.5;
//        [_comfirmBtn setTitle: forState:UIControlStateNormal];
//        _comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _comfirmBtn.text = @"立即体验";
        _comfirmBtn.font = [UIFont systemFontOfSize:15];
        _comfirmBtn.textColor = [UIColor whiteColor];
        _comfirmBtn.textAlignment = NSTextAlignmentCenter;
        [_scroll addSubview:_comfirmBtn];
    }
    else{
        [_scroll addSubview:_comfirmBtn];
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

- (void) setContentMode:(UIViewContentMode)contentMode
{
    _contentMode = contentMode;

    for (int i = 0; i<_totalCount; i++) {

        UIImageView *imageview = [self viewWithTag:1000+i];
        imageview.contentMode = self.contentMode;
    }
}


#pragma mark - 代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/ScreenWidth;
    _pageCotroll.currentPage = page;
}
@end
