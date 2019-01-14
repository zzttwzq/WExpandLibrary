//
//  WRequestStatueView.h
//  Pods
//
//  Created by 吴志强 on 2018/7/17.
//

#import "WBasicHeader.h"

//状态
typedef NS_ENUM(NSInteger,WViewLoadingType) {
    WViewLoadingType_None,           //没有等待状态
    WViewLoadingType_IsLoading,      //等待状态正在加载
    WViewLoadingType_LoadError,      //等待状态加载错误
    WViewLoadingType_LoadSuccess,    //等待状态加载成功
    WViewLoadingType_NoNetWork,      //等待状态无网络
};

typedef void (^StateBlock)(BOOL state);

@interface WRequestStatueView : UIView
@property (nonatomic,strong) UIImageView *logoImage;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UIButton *retryBtn;

/**
 监听网络是否改变
 */
@property (nonatomic,assign) BOOL listenNetWorkChange;


/**
 状态类型
 */
@property (nonatomic,assign) WViewLoadingType type;


/**
 刷新回调
 */
@property (nonatomic,copy) StateBlock refresh;


/**
 初始化text

 @param imageName 图片名称
 @param text 说明文字
 @return 返回实体
 */
- (instancetype) initWithImageName:(NSString *)imageName
                              text:(NSString *)text;


/**
 设置内容的位置

 @param offset 要设置的位置
 */
- (void) setContentViewOffset:(float)offset;

@end
