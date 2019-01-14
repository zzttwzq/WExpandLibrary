//
//  UIView+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <UIKit/UIKit.h>

@interface UIView (WHandler)

#pragma mark - 属性方法
@property (nonatomic,assign) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic,assign) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic,assign) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic,assign) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic,assign) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic,assign) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint center;


#pragma mark - 子视图操作
/**
 根据类名来获取子view

 @param className 类名
 @return 子view
 */
- (UIView *) subViewOfClassName:(NSString*)className;


/**
 根据类名来获取子view 数组

 @param className 类名
 @return 子view 数组
 */
- (NSArray *) subViewsOfClassName:(NSString*)className;


/**
 移除所有子视图
 */
- (void) removeAllSubViews;


/**
 添加线

 @param rect 位置
 @param color 颜色
 */
- (UIView *) addLineWithRect:(CGRect)rect
                       color:(UIColor *)color;


/**
 画点虚线

 @param rect 线的位置和大小
 @param lineWidth 短线的宽度
 @param lineSpace 短线的间距
 @param lineColor 线的颜色
 @param isVertical 水平还是垂直（默认no，水平）
 */
- (void) addDashLineWithRect:(CGRect)rect
                   lineWidth:(float)lineWidth
                   lineSpace:(float)lineSpace
                   lineColor:(UIColor *)lineColor
                  isVertical:(BOOL)isVertical;


/**
 根据选择位置旋转视图

 @param rotate 旋转方向
 */
- (void) rotateWithUIImageOrientation:(UIImageOrientation)rotate;



/**
 顺时针旋转视图

 @param degress 角度
 */
- (void) clockwiseRotate:(NSInteger)degress;




/**
 添加虚化效果

 @param effects 效果的颜色
 */
- (void) addBlurEffectStyle:(UIBlurEffectStyle)effects;


/**
 生成阴影view

 @param frame frame
 @param color 颜色
 @param offset 阴影扩散范围
 @param radius 阴影弧度
 @return 返回view
 */
+ (UIView *) viewWithFrame:(CGRect)frame
                     color:(UIColor *)color
                    offset:(CGSize)offset
                    radius:(float)radius;

/**
 生成阴影
 
 @param color 颜色
 @param offset 阴影扩散范围
 @param radius 阴影弧度
 */
- (void) shadowWithColor:(UIColor *)color
                  offset:(CGSize)offset
                  radius:(float)radius;


/**
 获取当前的viewcontroller

 @return 当前的控制器
 */
- (UIViewController *)currentViewController;


@end
