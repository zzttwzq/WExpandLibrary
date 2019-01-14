//
//  UIImage+WHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "UIImage+WHandler.h"

@implementation UIImage (WHandler)
#pragma mark - 生成图片
/**
 生成单色图片

 @param color 图片的颜色
 @param size 图片的尺寸
 @return 返回图片
 */
+ (UIImage *) imageWithColor:(UIColor *)color
                        size:(CGSize)size;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return theImage;
}


/**
 生成条形码

 @param barCode 条形码
 @param size 尺寸
 @return 返回图片
 */
+ (UIImage *) barCodeImageWithBarCode:(NSString *)barCode
                                 size:(CGSize)size;
{
    // 注意生成条形码的编码方式
    NSData *data = [barCode dataUsingEncoding: NSASCIIStringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];

    // 设置生成的条形码的上，下，左，右的margins的值
    [filter setValue:[NSNumber numberWithInteger:0] forKey:@"inputQuietSpace"];

    UIGraphicsBeginImageContext(size);
    [[UIImage imageWithCIImage:filter.outputImage] drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}


/**
 生成二维码

 @param QRCode 二维码
 @param size 尺寸
 @return 返回图片
 */
+ (UIImage *) QRCodeImageWithQRCode:(NSString *)QRCode
                               size:(CGSize)size;
{
    NSData *data = [QRCode dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];

    UIGraphicsBeginImageContext(size);
    [[UIImage imageWithCIImage:filter.outputImage] drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}


/**
 全屏截图

 @return 返回截图图片
 */
+ (UIImage *)getScreenShot;
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;

    UIGraphicsBeginImageContext(window.bounds.size);

    [window.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return image;
}


#pragma mark - 调整尺寸
/**
 重新调整图片尺寸

 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
- (UIImage *)reszie:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}


/**
 调整生成的图片的大小

 @param image 要缩小的图片
 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
+ (UIImage *) resizeCodeImage:(CIImage *)image
                     withSize:(CGSize)size;
{
    if (image) {

        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scaleWidth = size.width/CGRectGetWidth(extent);
        CGFloat scaleHeight = size.height/CGRectGetHeight(extent);
        size_t width = CGRectGetWidth(extent) * scaleWidth;
        size_t height = CGRectGetHeight(extent) * scaleHeight;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
        CGContextRef contentRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imageRef = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(contentRef, kCGInterpolationNone);
        CGContextScaleCTM(contentRef, scaleWidth, scaleHeight);
        CGContextDrawImage(contentRef, extent, imageRef);
        CGImageRef imageRefResized = CGBitmapContextCreateImage(contentRef);

        UIImage * changeimg = [UIImage imageWithCGImage:imageRefResized];

        CGContextRelease(contentRef);
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorSpaceRef);
        CGImageRelease(imageRefResized);
        return changeimg;

    }else{

        return nil;
    }
}


#pragma mark - 压缩图片
/**
 压缩图片到指定文件大小

 @param size 要缩小的尺寸
 @return 返回缩小后的尺寸
 */
- (NSData *)compresstoMaxDataSizeKBytes:(CGFloat)size;
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);

    CGFloat dataKBytes = data.length/1000.0;

    CGFloat maxQuality = 0.9f;

    CGFloat lastData = dataKBytes;

    while (dataKBytes > size && maxQuality > 0.01f) {

        maxQuality = maxQuality - 0.01f;

        data = UIImageJPEGRepresentation(self, maxQuality);

        dataKBytes = data.length/1000.0;

        if (lastData == dataKBytes) {

            break;
        }else{

            lastData = dataKBytes;
        }
    }
    return data;
}


#pragma mark - 对图片进行处理
/**
 图片模糊处理

 @param name 模糊方式
 // CIGaussianBlur ---> 高斯模糊
 // CIBoxBlur      ---> 均值模糊(Available in iOS 9.0 and later)
 // CIDiscBlur     ---> 环形卷积模糊(Available in iOS 9.0 and later)
 // CIMedianFilter ---> 中值模糊, 用于消除图像噪点, 无需设置radius(Available in iOS 9.0 and later)
 // CIMotionBlur   ---> 运动模糊, 用于模拟相机移动拍摄时的扫尾效果(Available in iOS 9.0 and later)

 @param radius 模糊度
 @return 返回图片
 */
- (UIImage *) imageBlurWithName:(NSString *)name
                         radius:(NSInteger)radius;
{
    if (name.length != 0) {

        CIContext *context = [CIContext contextWithOptions:nil];

        CIImage *inputImage = [[CIImage alloc] initWithImage:self];

        CIFilter *filter = [CIFilter filterWithName:name];

        [filter setValue:inputImage forKey:kCIInputImageKey];

        if (![name isEqualToString:@"CIMedianFilter"]) {

            [filter setValue:@(radius) forKey:@"inputRadius"];
        }

        CIImage *result = [filter valueForKey:kCIOutputImageKey];

        CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];

        UIImage *resultImage = [UIImage imageWithCGImage:cgImage];

        CGImageRelease(cgImage);

        return resultImage;

    }

    return nil;
}


/**
 *  调整图片饱和度, 亮度, 对比度
 *
 *  @param saturation 饱和度 0 ~ 1.0
 *  @param brightness 亮度: -1.0 ~ 1.0
 *  @param contrast   对比度 0 ~ 1.0
 *
 */
- (UIImage *) imageSaturation:(CGFloat)saturation
                    brightness:(CGFloat)brightness
                      contrast:(CGFloat)contrast;
{
    CIContext *context = [CIContext contextWithOptions:nil];

    CIImage *inputImage = [[CIImage alloc] initWithImage:self];

    CIFilter *filter = [CIFilter filterWithName:@"CIColorControls"];

    [filter setValue:inputImage forKey:kCIInputImageKey];

    [filter setValue:@(saturation) forKey:@"inputSaturation"];

    [filter setValue:@(brightness) forKey:@"inputBrightness"];// 0.0 ~ 1.0

    [filter setValue:@(contrast) forKey:@"inputContrast"];

    CIImage *result = [filter valueForKey:kCIOutputImageKey];

    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];

    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];

    CGImageRelease(cgImage);

    return resultImage;
}



// CILinearToSRGBToneCurve, CISRGBToneCurveToLinear, CIGaussianBlur, CIBoxBlur, CIDiscBlur, CISepiaTone, CIDepthOfField

/**
 调整图片效果

 @param name 图片效果
 // 怀旧 --> CIPhotoEffectInstant                         单色 --> CIPhotoEffectMono
 // 黑白 --> CIPhotoEffectNoir                            褪色 --> CIPhotoEffectFade
 // 色调 --> CIPhotoEffectTonal                           冲印 --> CIPhotoEffectProcess
 // 岁月 --> CIPhotoEffectTransfer                        铬黄 --> CIPhotoEffectChrome

 @return 返回图片
 */
- (UIImage *) imageEffectWithName:(NSString *)name;
{
    CIContext *context = [CIContext contextWithOptions:nil];

    CIImage *inputImage = [[CIImage alloc] initWithImage:self];

    CIFilter *filter = [CIFilter filterWithName:name];

    [filter setValue:inputImage forKey:kCIInputImageKey];

    CIImage *result = [filter valueForKey:kCIOutputImageKey];

    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];

    UIImage *resultImage = [UIImage imageWithCGImage:cgImage];

    CGImageRelease(cgImage);

    return resultImage;
}


@end
