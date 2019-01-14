//
//  UIView+WHandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/13.
//

#import "UIView+WHandler.h"

@implementation UIView (WHandler)

#pragma mark - 属性方法
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void) setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat) top {
    return self.frame.origin.y;
}

- (void) setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat) right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat) bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat) width {
    return self.frame.size.width;
}

- (void) setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat) height {
    return self.frame.size.height;
}

- (void) setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize) size {
    return self.frame.size;
}

- (void) setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint) center {
    return self.frame.origin;
}

- (void) setCenter:(CGPoint)center {
    CGRect frame = self.frame;
    frame.origin = center;
    self.frame = frame;
}

- (CGFloat) centerX
{
    return self.center.x;
}

- (void) setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat) centerY
{
    return self.center.y;
}

- (void) setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark - 子视图操作
/**
 根据类名来获取子view

 @param className 类名
 @return 子view
 */
- (UIView *) subViewOfClassName:(NSString*)className;
{
    for (UIView* subView in self.subviews) {

        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }

        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {

            return resultFound;
        }
    }
    return nil;
}

/**
 根据类名来获取子view 数组

 @param className 类名
 @return 子view 数组
 */
- (NSArray *) subViewsOfClassName:(NSString*)className;
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIView* subView in self.subviews) {

        if ([NSStringFromClass(subView.class) isEqualToString:className]) {

            [array addObject:subView];
        }
    }

    return [array mutableCopy];
}

/**
 移除所有子视图
 */
- (void) removeAllSubViews;
{
    for (UIView* subView in self.subviews) {

        [subView removeFromSuperview];
    }
}


/**
 添加线

 @param rect 位置
 @param color 颜色
 */
- (UIView *) addLineWithRect:(CGRect)rect
                       color:(UIColor *)color;
{
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = color;

    [self addSubview:line];

    return line;
}


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
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];

    // 设置虚线颜色
    [shapeLayer setStrokeColor:lineColor.CGColor];

    // 设置虚线宽度
    [shapeLayer setLineJoin:kCALineJoinRound];

    // 设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineWidth], [NSNumber numberWithInt:lineSpace], nil]];

    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
//    if (isVertical == YES) {
//
//        [shapeLayer setPosition:position];
//        [shapeLayer setLineWidth:lineWidth];
//        CGPathAddLineToPoint(path, NULL, 0, lineHeight);
//    }else{
//
//        [shapeLayer setPosition:position];
//        [shapeLayer setLineWidth:lineWidth];
//        CGPathAddLineToPoint(path, NULL, lineWidth, 0);
//    }


    [shapeLayer setPosition:rect.origin];
    [shapeLayer setLineWidth:lineWidth];
    CGPathAddLineToPoint(path, NULL, 0, rect.size.height);


    [shapeLayer setPath:path];
    CGPathRelease(path);

    // 把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
}


/**
 旋转视图

 @param rotate 旋转方向
 */
-(void)rotateWithUIImageOrientation:(UIImageOrientation)rotate;
{
    if (rotate == UIImageOrientationUp) {

        self.transform = CGAffineTransformMakeRotation(0/180.0 * M_PI);
    }else if (rotate == UIImageOrientationDown) {

        self.transform = CGAffineTransformMakeRotation(180/180.0 * M_PI);
    }else if (rotate == UIImageOrientationLeft) {

        self.transform = CGAffineTransformMakeRotation(90/180.0 * M_PI);
    }else if (rotate == UIImageOrientationRight) {

        self.transform = CGAffineTransformMakeRotation(270/180.0 * M_PI);
    }
}


/**
 旋转视图

 @param degress 角度
 */
-(void)clockwiseRotate:(NSInteger)degress;
{
    self.transform = CGAffineTransformMakeRotation(degress/180.0 * M_PI);
}


/**
 添加虚化效果

 @param effects 效果的颜色
 */
- (void) addBlurEffectStyle:(UIBlurEffectStyle)effects;
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:effects];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.bounds;

    [self addSubview:effectView];
}


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
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = 0.5;
    view.layer.shadowRadius = radius;

    return view;
}


/**
 生成阴影

 @param color 颜色
 @param offset 阴影扩散范围
 @param radius 阴影弧度
 */
- (void) shadowWithColor:(UIColor *)color
                offset:(CGSize)offset
                radius:(float)radius;
{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = radius;
}


/**
 获取当前的viewcontroller

 @return 当前的控制器
 */
- (UIViewController *)currentViewController;
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){

        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){

            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])

        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

@end
