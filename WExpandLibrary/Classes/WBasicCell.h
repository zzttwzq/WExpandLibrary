//
//  WBasicCell.h
//  yinghong
//
//  Created by 吴志强 on 2017/11/16.
//  Copyright © 2017年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBasicCell : UITableViewCell
@property (nonatomic,strong) id model;


/**
 实例化的类方法

 @param tableView 对象tableview
 @return 返回实例化的cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;


/**
 自定义视图
 */
-(void)custmView;

@end
