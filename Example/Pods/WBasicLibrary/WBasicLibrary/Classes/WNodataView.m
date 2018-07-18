//
//  WNodataView.m
//  Pods
//
//  Created by 吴志强 on 2018/7/17.
//

#import "WNodataView.h"

@implementation WNodataView

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

        int height = ScreenHeight*0.3;
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-100)/2, height, 100, 100)];
        [self addSubview:self.logoImage];

        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.logoImage.bottom+10, ScreenWidth, 30)];
        [self addSubview:self.descriptionLabel];
    }
    return self;
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

@end
