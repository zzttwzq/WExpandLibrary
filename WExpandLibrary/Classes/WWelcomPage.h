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
@property(nonatomic,copy) void(^state)(BOOL state);

/**
 初始化方法（会自动判断是否是url或者是图片格式）

 @param images 图片数组
 @param enablePageControl 是否开启pagectroll
 @return 返回新建的实例
 */
-(instancetype)initWithImages:(NSArray *)images enablePageControl:(BOOL)enablePageControl;



/**
 取消导航view
 */
-(void)dismiss;
@end
