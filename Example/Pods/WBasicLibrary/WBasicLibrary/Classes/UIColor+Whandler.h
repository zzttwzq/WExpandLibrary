//
//  UIColor+Whandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <UIKit/UIKit.h>

@interface UIColor (Whandler)

/**
 hex颜色字符串转 uicolor

 @param hexString 颜色的hex值
 @return 返回uicolor
 */
+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end
