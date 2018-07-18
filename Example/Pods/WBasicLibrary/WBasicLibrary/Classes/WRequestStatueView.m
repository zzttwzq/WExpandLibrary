//
//  WRequestStatueView.m
//  Pods
//
//  Created by 吴志强 on 2018/7/17.
//

#import "WRequestStatueView.h"

@implementation WRequestStatueView

/**
 初始化text

 @param imageName 图片名称
 @param text 说明文字
 @return 返回实体
 */
- (instancetype) initWithImageName:(NSString *)imageName
                              text:(NSString *)text;
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    if (self) {

        self.backgroundColor = [UIColor whiteColor];
        self.opaque = YES;
        self.userInteractionEnabled = YES;
        self.listenNetWorkChange = YES;

        int height = ScreenHeight*0.3;
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-100)/2, height, 100, 100)];
        [self addSubview:self.logoImage];

        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImage.bottom+10, ScreenWidth, 30)];
        [self addSubview:self.descriptionLabel];


        self.retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.retryBtn.frame = CGRectMake((ScreenWidth-120)/2, self.descriptionLabel.bottom+20, 120, 40);
        self.retryBtn.backgroundColor = [UIColor blackColor];
        self.retryBtn.layer.cornerRadius = 5;
        self.retryBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        self.retryBtn.layer.masksToBounds = YES;
        self.retryBtn.alpha = 0;
        [self.retryBtn addTarget:self action:@selector(retryBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.retryBtn];


        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    }
    return self;
}


/**
 监听网络状态。

 @param note 通知
 */
-(void)reachabilityChanged:(NSNotification *)note
{
    if (self.listenNetWorkChange) {

        Reachability *rech = [note object];
        if ([rech currentReachabilityStatus] == ReachableViaWiFi) {

            self.type = WViewLoadingType_IsLoading;
        }
        else if ([rech currentReachabilityStatus] == ReachableViaWWAN) {

            self.type = WViewLoadingType_IsLoading;
        }
        else if ([rech currentReachabilityStatus] == NotReachable) {

            self.type = WViewLoadingType_NoNetWork;
        }
    }
}


/**
 重新加载按钮点击
 */
-(void)retryBtnClick
{
    if (_type == WViewLoadingType_LoadError ||
        _type == WViewLoadingType_IsLoading ||
        _type == WViewLoadingType_NoNetWork){

            //刷新页面
        if (_refresh) {
            _refresh(YES);
        }
    }
    else if (_type == WViewLoadingType_NoNetWork){

        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([ [UIApplication sharedApplication] canOpenURL:url]){

            [[UIApplication sharedApplication] openURL:url];
        }
    }
}


/**
 设置网络状态

 @param type 网络状态
 */
-(void)setType:(WViewLoadingType)type
{
    _type = type;

    [UIView animateWithDuration:0.3 animations:^{

        if (self.type == WViewLoadingType_LoadError){

            self.retryBtn.alpha = 1;
            self.alpha = 1;

            self.descriptionLabel.text = @"加载失败...";
            [self.retryBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        }
        else if (self.type == WViewLoadingType_IsLoading){

            self.retryBtn.alpha = 0;
            self.alpha = 1;

            self.descriptionLabel.text = @"加载中...";
        }
        else if (self.type == WViewLoadingType_NoNetWork){

            self.retryBtn.alpha = 1;
            self.alpha = 1;

            self.descriptionLabel.text = @"没有网络啦，建议检查网络是否开启";
            [self.retryBtn setTitle:@"去设置" forState:UIControlStateNormal];
        }
        else if (self.type == WViewLoadingType_LoadSuccess){

            self.alpha = 0;
        }
        else if (self.type == WViewLoadingType_None){

            self.alpha = 0;
        }
    }];
}



/**
 设置内容的位置

 @param offset 要设置的位置
 */
- (void) setContentViewOffset:(float)offset;
{
    self.logoImage.top = offset;
    self.descriptionLabel.top = self.logoImage.bottom+10;
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

@end
