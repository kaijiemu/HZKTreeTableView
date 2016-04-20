//
//  SQLTool.m
//  UITableViewTest
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SQLTool.h"
#import "SiteModel.h"
#import "FMDB.h"

/**基础数据库*/
static FMDatabase *_db;

@implementation SQLTool



+(void)initialize
{
    
    // 1.打开数据库 
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"province.db"];
    
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
}



/**获取分站选择信息*/
- (NSMutableArray *)SiteData
{
    NSMutableArray * parentArr = [self siteModelWithParentID:0];
    for (int i = 0; i < parentArr.count; i++) {
        
        
        SiteModel * site = parentArr[i];
        NSMutableArray * parentArr1 = [self siteModelWithParentID:site.siteId];
        for (int i = 0; i < parentArr1.count; i++) {
            
            //        parentArr[i].ch
            //        model.children = [self siteModelWithParentID:model.siteId];
            SiteModel * site2 = parentArr1[i];
            NSMutableArray * parentArr2 = [self siteModelWithParentID:site2.siteId];
            site2.children = parentArr2;
            
        }
        site.children = parentArr1;
        
    }
    
    
    return parentArr;
}


-(NSMutableArray *)siteModelWithParentID:(int )parentID
{
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM tb_site where parent_site_id = %d",parentID];
    FMResultSet *set = [_db executeQuery:sqlStr];
    // 不断往下取数据
    NSMutableArray *siteArr = [NSMutableArray array];
    
    while (set.next) {
        SiteModel * site = [[SiteModel alloc]init];
        
        site.siteId = [set intForColumn:@"SITE_ID"];
        site.siteName = [set stringForColumn:@"SITE_NAME"];
        site.parentId = [set intForColumn:@"PARENT_SITE_ID"];
        site.unfold = NO; //默认都不展开

        
        [siteArr addObject:site];
    }
    
    
    return siteArr;
}





@end



