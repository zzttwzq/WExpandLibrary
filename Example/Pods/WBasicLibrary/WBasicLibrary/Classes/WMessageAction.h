//
//  WMessageAction.h
//  Pods
//
//  Created by 吴志强 on 2018/7/16.
//

#import <UIKit/UIKit.h>

@interface WMessageAction : UIAlertAction

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

@end
