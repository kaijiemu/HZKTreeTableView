//
//  TableViewCell.h
//  UITableViewTest
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewCellDelegate <NSObject>
@optional
- (void)TableViewCellDidSelectWithProvinceName:(NSString *)provinceName andCityName:(NSString *)cityName;
@end




@interface TableViewCell : UITableViewCell

/**代理*/
@property (nonatomic, weak) id<TableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**文字label*/
@property (weak, nonatomic) IBOutlet UILabel *lable;

/**旋转的箭头图片*/
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

/**分组的城市数组*/
@property(strong,nonatomic)NSArray * cityArray;


/**设置图片箭头旋转*/
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold;

@end
