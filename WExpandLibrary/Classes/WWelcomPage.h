//
//  WWelcomPage.h
//  wzqFundation
//
//  Created by 吴志强 on 2017/11/4.
//  Copyright © 2017年 吴志强. All rights reserved.
//

//#import "Definitions.h"
#import "WFileManager.h"

@interface WWelcomPage : UIView
@property (nonatomic,assign) UIViewContentMode contentMode;
@property(nonatomic,copy) void(^state)(BOOL state);
@property (nonatomic,strong) UILabel *comfirmBtn;

/**
 类方法实例化对象 （会自动判断是否是url或者是图片格式）

 @param iphoneImages iphone 图片数组
 @param iphonexImages iphonex 图片数组
 @param enablePageControl 是否显示pagectroll
 */
+ (void) configGuideViewWithIphoneImages:(NSArray *)iphoneImages
                           iphonexImages:(NSArray *)iphonexImages
                       enablePageControl:(BOOL)enablePageControl;

@end
