//
//  UIViewController+BasicHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "UIViewController+BasicHandler.h"
#import <objc/runtime.h>

const char listenKeyBoarderFrameChange;

@implementation UIViewController (BasicHandler)

#pragma mark 属性关联
-(void)setListenKeyBoarderFrameChange:(BOOL)listenKeyBoarderFrameChange
{
    objc_setAssociatedObject(self, &listenKeyBoarderFrameChange,
                             @(listenKeyBoarderFrameChange),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)loadingView{
    return objc_getAssociatedObject(self, &listenKeyBoarderFrameChange);
}







/**
 打开升级下载页

 @param appid appid
 */
- (void) openDownLoadInAppStoreWithAPPID:(NSString *)appid;
{
//    [WHUDView showLoading];

    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appid forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {

//        [WHUDView dismissLoading];
        if (result) {

            [self presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}


/**
 打开评分

 @param appid appid
 */
- (void) openMarkInAppStoreWithAPPID:(NSString *)appid;
{
    if (@available(iOS 10.3, *)) {

        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]){

            [SKStoreReviewController requestReview];
        }
    } else {

        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", appid]]];
    }
}
@end
