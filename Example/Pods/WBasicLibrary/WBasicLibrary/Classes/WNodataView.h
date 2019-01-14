//
//  WNodataView.h
//  Pods
//
//  Created by 吴志强 on 2018/7/17.
//

#import "WBasicHeader.h"

@interface WNodataView : UIView
@property (nonatomic,strong) UIImageView *logoImage;
@property (nonatomic,strong) UILabel *descriptionLabel;

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
