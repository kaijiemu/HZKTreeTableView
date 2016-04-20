//
//  TableViewCell.m
//  UITableViewTest
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "TableViewCell.h"
#import "SiteModel.h"


#define M_PI        3.14159265358979323846264338327950288   /* pi             */
#define M_PI_2      1.57079632679489661923132169163975144   /* pi/2           */

@interface TableViewCell()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation TableViewCell

- (void)awakeFromNib {
    
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //tableView 去掉cell的分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _cityArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        
    }
    SiteModel * city = _cityArray[indexPath.row];
    
    cell.textLabel.text = city.siteName;
    
    return cell;
}

/**
 *  代理方法通知外界选中了哪个省和市
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiteModel * city = _cityArray[indexPath.row];
    NSString *cityName = city.siteName;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(TableViewCellDidSelectWithProvinceName:andCityName:)]) {
        [self.delegate TableViewCellDidSelectWithProvinceName:self.lable.text andCityName:cityName];
    }
}


/**
 *设置cell的背景色
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
}

/**
 *   设置图片箭头旋转
 */
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold
{
    
    double degree;
    if(unfold ){
        degree = M_PI;
    }
    else{
        degree = 0;
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _arrowImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
    
    
//    if (unfold)
//    {
//
//        [UIView animateWithDuration:0.2 animations:^{
//            _arrowImageView.transform = CGAffineTransformMakeRotation(M_PI);
//        }];
//        
//    } else {
//
//        [UIView animateWithDuration:0.2 animations:^{
//            _arrowImageView.transform = CGAffineTransformIdentity;
//        }];
//    }
}



@end
