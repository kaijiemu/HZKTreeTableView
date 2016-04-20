//
//  MainViewController.m
//  UITableViewTest
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "MainViewController.h"
#import "TableViewCell.h"
#import "SQLTool.h"
#import "SiteModel.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,TableViewCellDelegate>

@property (strong,nonatomic)UITableView *tableView;

@property (nonatomic,strong) NSMutableArray * showArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化tableview
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    _showArray = [[[SQLTool alloc] init] SiteData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return _showArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    SiteModel * child = _showArray[section];
    return child.children.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell;
    static NSString *ID = @"TableViewCell";
    cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell=array[0];
        cell.delegate = self;
        //设置cell点击无任何效果和背景色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        
    }
    
    SiteModel * child = _showArray[indexPath.section];
    SiteModel *site = child.children[indexPath.row];
    cell.lable.text = site.siteName;

    //该省下面的城市
    cell.cityArray = site.children;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SiteModel * child = _showArray[indexPath.section];
    SiteModel *site = child.children[indexPath.row];
    if (site.unfold) {
        
        return site.children.count * 44 + 44;
    }
    return 44;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    SiteModel * child = _showArray[indexPath.section];
    SiteModel *site = child.children[indexPath.row];
    //是否展开
    site.unfold = !site.unfold;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

    
    /**设置图片箭头旋转*/
    TableViewCell *cell = (TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setArrowImageViewWhitIfUnfold:site.unfold];
    
     [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
}

//设置section头部的间距
- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//设置section头部的数据
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //设置section头部的背景为透明的
    UIView *sectionHeaderView = [[UIView alloc] init];
    sectionHeaderView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 20)];
    
    SiteModel *siteModel = _showArray[section];
    
    label.text = siteModel.siteName;
    label.font = [UIFont systemFontOfSize:12.f];
    
    [sectionHeaderView addSubview:label];
    
    return sectionHeaderView;
}

#pragma mark -- TableViewCellDelegate
/**
 *   代理方法:选中了哪个省和市
 */
-(void)TableViewCellDidSelectWithProvinceName:(NSString *)provinceName andCityName:(NSString *)cityName
{
    NSLog(@"provinceName--%@,cityName--%@",provinceName,cityName);
    
    NSString *message = [NSString stringWithFormat:@"%@,%@",provinceName,cityName];
    [[[UIAlertView alloc] initWithTitle:@"您选中了" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}


@end
