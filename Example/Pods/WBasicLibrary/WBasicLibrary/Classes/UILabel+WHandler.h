//
//  UILabel+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "WBasicHeader.h"

//typedef NS_ENUM(NSInteger,WLableTextPosition) {
//    WLableTextPosition_top_left,
//    WLableTextPosition_top_center,
//    WLableTextPosition_top_right,
//    WLableTextPosition_middle_left,
//    WLableTextPosition_middle_center,
//    WLableTextPosition_middle_right,
//    WLableTextPosition_bottom_left,
//    WLableTextPosition_bottom_center,
//    WLableTextPosition_bottom_right,
//};

@interface UILabel (WHandler)

/**
 让lab适应字体宽高

 @param text 要设置的文字
 @param font 字体
 @param maxSize 最大的尺寸
 @param autoWith 最大的尺寸
 @param autoHeight 最大的尺寸
 */
- (void) adjustSizeWithText:(NSString *)text
                       font:(UIFont *)font
                    maxSize:(CGSize)maxSize
                   autoWith:(BOOL)autoWith
                 autoHeight:(BOOL)autoHeight;

/**
 让lab自适应宽度

 @param maxHeight 高度固定
 @param text 要调整的字符串
 */
- (void) adjustWithMaxHeight:(float)maxHeight
                        text:(NSString *)text;


/**
 让lab自适应高度

 @param maxWidth 宽度固定
 @param text 要调整的字符串
 */
- (void) adjustWithMaxWidth:(float)maxWidth
                       text:(NSString *)text;


/**
 让lab自动适应宽高

 @param text 要调整的字符串
 */
- (void) adjustWithText:(NSString *)text;

@end
