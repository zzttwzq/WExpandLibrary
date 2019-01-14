//
//  UIAlertController+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import "WMessageAction.h"

@interface UIAlertController (WHandler)

#pragma mark - 显示系统消息
/**
 生成系统提示，可以是alert 也可以是 actionsheet

 @param alertType 消息展现形式（alertview，actionsheet）
 @param target 在哪个控制器
 @param title 标题
 @param message 消息
 @param actions 按钮数组
 @param comfirmAction 确定点击事件
 */
+(void)showSystemAlertWithalertType:(UIAlertControllerStyle)alertType
                             target:(UIViewController *)target
                              Title:(NSString *)title
                            message:(NSString *)message
                            actions:(NSArray *)actions
                      comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;


#pragma mark - 显示alert提示框
/**
 显示弹出提示 只有确定和取消按钮，颜色是系统默认的颜色

 @param target 在哪个控制器
 @param enableCancelBtn 显示取消按钮
 @param message 消息内容
 @param comfirmAction 确定点击事件
 */
+(void)showAlertWithTarget:(UIViewController *)target
          enableCancelBtn:(BOOL)enableCancelBtn
                  message:(NSString *)message
            comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;


/**
 显示弹出提示 只有确定和取消按钮，颜色是系统默认的颜色

 @param title 标题
 @param target 在哪个控制器
 @param enableCancelBtn 显示取消按钮
 @param message 消息内容
 @param comfirmAction 确定点击事件
 */
+(void)showAlertWithTitle:(NSString *)title
                   target:(UIViewController *)target
          enableCancelBtn:(BOOL)enableCancelBtn
                  message:(NSString *)message
            comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;


/**
 显示弹出提示（可以改按钮个数，按钮颜色）

 @param target 在哪个控制器
 @param title 消息内容
 @param message 消息内容
 @param actions 按钮名称
 @param colors 按钮颜色
 @param comfirmAction 确定点击事件
 */
+(void)showAlertWithTarget:(UIViewController *)target
                     title:(NSString *)title
                   message:(NSString *)message
                   actions:(NSArray *)actions
                    colors:(NSArray *)colors
             comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;


#pragma mark - 显示actionsheet提示框
/**
 显示actionsheet 可以自定义按钮个数 但是颜色不能更改

 @param title 标题
 @param target 在哪个控制器
 @param enableCancelBtn 在哪个控制器
 @param message 消息内容
 @param comfirmText 确定的消息
 @param actionNames 确定的消息
 @param comfirmAction 确定点击事件
 */
+(void)showActionSheetWithTitle:(NSString *)title
                         target:(UIViewController *)target
                enableCancelBtn:(BOOL)enableCancelBtn
                        message:(NSString *)message
                    comfirmText:(NSString *)comfirmText
                    actionNames:(NSArray *)actionNames
                  comfirmAction:(void(^)(UIAlertAction *action))comfirmAction;
@end
