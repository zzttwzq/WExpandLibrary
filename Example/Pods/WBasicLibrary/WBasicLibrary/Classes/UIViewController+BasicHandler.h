//
//  UIViewController+BasicHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface UIViewController (BasicHandler)

//监听键盘
@property (nonatomic,assign) BOOL listenKeyBoarderFrameChange;

//设置返回按钮
@property (nonatomic,assign) BOOL showLeftBtn;


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
