//
//  WHUDView.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import <UIKit/UIKit.h>
#import "MicroDefinetion.h"

@interface WHUDView : UIView

/**
 显示view
 */
+ (void) showLoadingWithMessage:(NSString *)message;


+ (void) showLoading;


/**
 取消view
 */
+ (void) dismissLoading;


+ (void) dismissMessage;
@end
