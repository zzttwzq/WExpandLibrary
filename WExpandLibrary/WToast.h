//
//  WToast.h
//  Pods-WMessage_Tests
//
//  Created by 吴志强 on 2018/7/16.
//

#import <Foundation/Foundation.h>

//toast位置
typedef NS_ENUM(NSInteger,FYMESSAGE_POSITION) {
    FYMESSAGE_POSITION_TYPE_TOP,
    FYMESSAGE_POSITION_TYPE_MIDDLE,
    FYMESSAGE_POSITION_TYPE_BOTTOM
};

//toast动画
typedef NS_ENUM(NSInteger,FYMESSAGE_ANIMATION) {
    FYMESSAGE_ANIMATION_TYPE_FADE,
    FYMESSAGE_ANIMATION_TYPE_SLIPFROMTOP,
    FYMESSAGE_ANIMATION_TYPE_SLIPFROMBOTTOM
};

@interface WToast : NSObject

#pragma mark - 显示吐司消息
/**
 吐司消息

 @param toastMessage 要显示的吐司消息
 */
+(void)showToast:(NSString *)toastMessage;


/**
 toast消息

 @param message 消息
 @param position 位置
 @param isWhite 是否是白色
 @param Animat 是否有动画
 */
+(void)showMessage:(NSString *)message
fromBottomPosition:(FYMESSAGE_POSITION)position
           isWhite:(BOOL)isWhite Animat:(BOOL)Animat;

@end
