//
//  WBasicCell.m
//  yinghong
//
//  Created by 吴志强 on 2017/11/16.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import "WBasicCell.h"

@interface WBasicCell ()


@end

@implementation WBasicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self custmView];
    }
    return self;
}


/**
 实例化的类方法

 @param tableView 对象tableview
 @return 返回实例化的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
{
    static NSString *identifier = @"WBasicCell";
    // 1.缓存中取
    WBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    // 2.创建
    if (cell == nil) {
        cell = [[WBasicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


/**
 自定义视图
 */
-(void)custmView;{}


/**
 设置模型

 @param model 要设置的模型
 */
-(void)setModel:(id)model;{}
@end
