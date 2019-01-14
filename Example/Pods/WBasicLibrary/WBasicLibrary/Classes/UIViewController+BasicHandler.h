//
//  UIViewController+BasicHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <StoreKit/StoreKit.h>
#import "WRequestStatueView.h"
#import "WNodataView.h"

@class WNodataView,WRequestStatueView;

@interface UIViewController (BasicHandler) <SKStoreProductViewControllerDelegate>
/**
 设置触摸空白区域是否可以取消输入模式
 */
@property (nonatomic,assign) BOOL touchCacncelEditing;


/**
 设置触摸空白区域是否可以取消输入模式
 */
@property (nonatomic,strong) UITapGestureRecognizer *tapGuesture;


/**
 设置返回按钮
 */
@property (nonatomic,assign) BOOL showLeftBtn;


/**
 等待加载视图
 */
@property (nonatomic,strong) WRequestStatueView *statueView;


/**
 没有数据视图
 */
@property (nonatomic,retain) WNodataView *noDataView;


#pragma mark - 跳转到appstore
/**
 打开升级下载页

 @param appid appid
 */
- (void) openDownLoadInAppStoreWithAPPID:(NSString *)appid;


/**
 打开评分

 @param appid appid
 */
- (void) openMarkInAppStoreWithAPPID:(NSString *)appid;

@end
