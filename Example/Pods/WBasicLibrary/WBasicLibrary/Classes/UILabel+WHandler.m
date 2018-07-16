//
//  UILabel+WHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "UILabel+WHandler.h"

@implementation UILabel (WHandler)
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
{
    if (![text isKindOfClass:[NSString class]]) {

        [self showInfo:@"HMLabelHandler>>>不是正确的字符串！"];
        return;
    }
    else if (text.length == 0){

        [self showInfo:@"处理一个空字符串！"];
    }

    self.text = text;
    self.font = font;
    self.numberOfLines = 0;

    CGSize labSize = [text sizeWithFont:font maxSize:maxSize];


    //判断是否需要自动调整宽度
    if (!autoWith) {

        self.width = maxSize.width;
    }
    else{

        self.width = labSize.width;
        if (labSize.width > maxSize.width) {
            self.width = maxSize.width;
        }
    }


    //判断是否需要自动调整高度
    if (!autoHeight) {

        self.height = maxSize.width;
    }
    else{

        self.height = labSize.height;
        if (labSize.height > maxSize.height) {
            self.height = maxSize.height;
        }
    }
}


/**
 让lab自适应宽度

 @param maxHeight 高度固定
 @param text 要调整的字符串
 */
- (void) adjustWithMaxHeight:(float)maxHeight
                        text:(NSString *)text;
{
    [self adjustSizeWithText:text font:self.font maxSize:CGSizeMake(ScreenWidth, maxHeight) autoWith:YES autoHeight:NO];
}


/**
 让lab自适应高度

 @param maxWidth 宽度固定
 @param text 要调整的字符串
 */
-(void)adjustWithMaxWidth:(float)maxWidth
                        text:(NSString *)text;
{
    [self adjustSizeWithText:text font:self.font maxSize:CGSizeMake(maxWidth, ScreenHeight) autoWith:NO autoHeight:YES];
}


/**
 让lab自动适应宽高

 @param text 要调整的字符串
 */
-(void)adjustWithText:(NSString *)text;
{
    [self adjustSizeWithText:text font:self.font maxSize:CGSizeMake(ScreenWidth, ScreenHeight) autoWith:YES autoHeight:YES];

}


/**
 显示错误消息

 @param string 要显示的消息
 */
- (void) showInfo:(NSString *)string
{
    WLOG(@"<!警告!> <UILabel+WHandler> %@",string);
}
@end
