//
//  UIImage+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <UIKit/UIKit.h>

@interface UIImage (WHandler)
#pragma mark - 生成图片
/**
 创建一个单色的image

 @param color image的颜色
 @return 返回创建的image
 */
+ (UIImage *) imageWithColor:(UIColor*)color;


/**
 创建条形码

 @param barCode 条码
 @return 返回创建的image
 */
+ (CIImage *) imageWithBarCode:(NSString *)barCode;


/**
 二维码图片

 @param QRCode 二维码
 @return 返回创建的image
 */
+ (CIImage *) imageWtihQRCode:(NSString *)QRCode;


//+ (CIImage)

#pragma mark - 调整尺寸
/**
 缩小图片到一个尺寸

 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
- (UIImage *) scaledToSize:(CGSize)size;


/**
 调整生成的图片的大小

 @param image 要缩小的图片
 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
+ (UIImage *) resizeCodeImage:(CIImage *)image
                     withSize:(CGSize)size;


#pragma mark - 压缩图片
/**
 压缩图片到指定文件大小

 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
- (NSData *) compresstoMaxDataSizeKBytes:(CGFloat)size;


@end
