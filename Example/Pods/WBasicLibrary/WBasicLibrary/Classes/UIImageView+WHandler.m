//
//  UIImageView+WHandler.m
//  AFNetworking
//
//  Created by 吴志强 on 2019/1/14.
//

#import "UIImageView+WHandler.h"

@implementation UIImageView (WHandler)

/**
 创建一个webview 显示gif

 @param frame 尺寸
 @param url url链接
 @return 返回一个webview
 */
+ (UIWebView *) initWithFrame:(CGRect)frame
                          URL:(NSURL *)url;
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

    return webView;
}

@end
