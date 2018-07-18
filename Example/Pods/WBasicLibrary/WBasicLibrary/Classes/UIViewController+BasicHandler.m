//
//  UIViewController+BasicHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "UIViewController+BasicHandler.h"
#import <objc/runtime.h>


static const char touchCacncelEditingKey = 'a';
static const char showLeftBtnKey = 'b';
static const char tapGuest = 'c';
static const char statueViewKey = 'd';
static const char noDataKey = 'e';

@implementation UIViewController (BasicHandler)
@dynamic touchCacncelEditing;
@dynamic showLeftBtn;
@dynamic tapGuesture;

/**
 ========================================================================
 设置触摸空白区域是否可以取消输入模式
 ========================================================================
 */
- (void) setTouchCacncelEditing:(BOOL)touchCacncelEditing
{
    if (touchCacncelEditing) {

        self.tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchEND)];
        [self.view addGestureRecognizer:self.tapGuesture];
    }
    else{
        [self.view removeGestureRecognizer:self.tapGuesture];
    }

    objc_setAssociatedObject(self,
                             &touchCacncelEditingKey,
                             @(touchCacncelEditing),
                             OBJC_ASSOCIATION_ASSIGN);
}


- (BOOL) touchCacncelEditing
{
    return objc_getAssociatedObject(self, &touchCacncelEditingKey);
}


/**
 ========================================================================
 设置触摸空白区域是否可以取消输入模式
 ========================================================================
 */
- (void) setTapGuesture:(UITapGestureRecognizer *)tapGuesture
{
    objc_setAssociatedObject(self,
                             &tapGuest,
                             tapGuesture,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UITapGestureRecognizer *) tapGuesture
{
    return objc_getAssociatedObject(self, &tapGuest);
}


- (void) touchEND
{
    [self.view endEditing:YES];
}


/**
 ========================================================================
 设置导航条返回按钮
 ========================================================================
 */
- (void) setShowLeftBtn:(BOOL)showLeftBtn
{
    if (showLeftBtn) {

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"left_back_icon_40x20"] style:0 target:self action:@selector(back)];
    }else{

        self.navigationItem.leftBarButtonItem = nil;
    }

    objc_setAssociatedObject(self,
                             &showLeftBtnKey,
                             @(showLeftBtn),
                             OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL) showLeftBtn
{
    return objc_getAssociatedObject(self, &showLeftBtnKey);
}

- (void) back
{
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 ========================================================================
 等待视图
 ========================================================================
 */
- (void) setStatueView:(WRequestStatueView *)statueView
{
    if (self.statueView) {
        [self.statueView removeFromSuperview];
    }

    objc_setAssociatedObject(self,
                             &statueViewKey,
                             statueView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self.view addSubview:statueView];
}

- (WRequestStatueView *) statueView
{
    return objc_getAssociatedObject(self, &statueViewKey);
}


/**
 ========================================================================
 没有数据视图
 ========================================================================
 */
- (void) setNoDataView:(WNodataView *)noDataView
{
    objc_setAssociatedObject(self,
                             &noDataKey,
                             noDataView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self.view addSubview:noDataView];
}

- (WNodataView *) noDataView
{
    return objc_getAssociatedObject(self, &noDataKey);
}


/**
 打开升级下载页

 @param appid appid
 */
- (void) openDownLoadInAppStoreWithAPPID:(NSString *)appid;
{
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appid forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {

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
