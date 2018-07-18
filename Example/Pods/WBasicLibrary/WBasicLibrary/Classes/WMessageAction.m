//
//  WMessageAction.m
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import "WMessageAction.h"

@implementation WMessageAction

/**
 初始化方法

 @param text 显示的文字
 @param textColor 文字的颜色
 @param btnclick 按钮点击事件回调
 @return 返回实例化的消息按钮对象
 */
+(WMessageAction *)actionWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                         btnclick:(void(^)(UIAlertAction *action))btnclick;

{
    int style = UIAlertActionStyleDefault;
    if ([text isEqualToString:@"取消"]) {

        style = UIAlertActionStyleCancel;
    }
    WMessageAction *action = [WMessageAction actionWithTitle:text style:style handler:btnclick];
    [action setValue:textColor forKey:@"_titleTextColor"];

    return action;
}

@end
