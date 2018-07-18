//
//  UIView+WHandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import <UIKit/UIKit.h>

@interface UIView (WHandler)
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGSize size;


/**
 根据类名来获取子view

 @param className 类名
 @return 子view
 */
- (UIView*) subViewOfClassName:(NSString*)className;


/**
 画点虚线

 @param rect 线的位置和大小
 @param lineWidth 短线的宽度
 @param lineSpace 短线的间距
 @param lineColor 线的颜色
 @param isVertical 水平还是垂直（默认no，水平）
 */
- (void)drawDashLineWithRect:(CGRect)rect
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
 添加线

 @param rect 位置
 @param color 颜色
 */
- (void) addLineWithRect:(CGRect)rect
                   color:(UIColor *)color;

/**
 添加虚化效果

 @param effects 效果的颜色
 */
- (void) addBlurEffectStyle:(UIBlurEffectStyle)effects;


@end
