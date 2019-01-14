//
//  UIAlertController+WHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import "UIAlertController+WHandler.h"

@implementation UIAlertController (WHandler)

#pragma mark - 弹框消息
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
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertType];

        //修改标题的内容，字号，颜色。使用的key值是“attributedTitle”
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:message];
    [hogan addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedMessage"];

        //其他按钮
    for (int i = 0; i < actions.count; i++) {

        [alertController addAction:actions[i]];
    }
    [target presentViewController:alertController animated:YES completion:nil];
}


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
{
    [self showAlertWithTitle:nil target:target enableCancelBtn:enableCancelBtn message:message comfirmAction:comfirmAction];
}


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
{
    NSMutableArray *array = [NSMutableArray array];
    if (enableCancelBtn) {
        WMessageAction *actionCancel = [WMessageAction actionWithText:@"取消" textColor:nil btnclick:comfirmAction];
        [array addObject:actionCancel];
    }
    WMessageAction *actionConfirm = [WMessageAction actionWithText:@"确定" textColor:nil btnclick:comfirmAction];
    [array addObject:actionConfirm];

    [self showSystemAlertWithalertType:UIAlertControllerStyleAlert
                                target:target ? target : [UIApplication sharedApplication].keyWindow.rootViewController
                                 Title:title
                               message:message
                               actions:array
                         comfirmAction:comfirmAction];
}


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
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<actions.count; i++) {

        NSString *actionName = actions[i];
        UIColor *actionColor;
        if (colors.count > i &&
            [colors[i] isKindOfClass:[UIColor class]]) {

            actionColor = colors[i];
        }

        WMessageAction *actionConfirm = [WMessageAction actionWithText:actionName textColor:actionColor btnclick:comfirmAction];
        [array addObject:actionConfirm];
    }

    [self showSystemAlertWithalertType:UIAlertControllerStyleAlert
                                target:target ? target : [UIApplication sharedApplication].keyWindow.rootViewController
                                 Title:title
                               message:message
                               actions:array
                         comfirmAction:comfirmAction];
}


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
{
    NSMutableArray *array = [NSMutableArray array];
    if (enableCancelBtn) {
        WMessageAction *actionCancel = [WMessageAction actionWithText:@"取消" textColor:nil btnclick:comfirmAction];
        [array addObject:actionCancel];
    }
    WMessageAction *actionConfirm = [WMessageAction actionWithText:comfirmText textColor:nil btnclick:comfirmAction];
    [array addObject:actionConfirm];

    [self showSystemAlertWithalertType:UIAlertControllerStyleActionSheet
                                target:target ? target : [UIApplication sharedApplication].keyWindow.rootViewController
                                 Title:title
                               message:message
                               actions:array comfirmAction:comfirmAction];
}


@end
