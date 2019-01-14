//
//  UIImageView+WHandler.h
//  AFNetworking
//
//  Created by 吴志强 on 2019/1/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (WHandler)

/**
 创建一个webview 显示gif

 @param frame 尺寸
 @param url url链接
 @return 返回一个webview
 */
+ (UIWebView *) initWithFrame:(CGRect)frame
                          URL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
