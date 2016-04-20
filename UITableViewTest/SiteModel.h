//
//  SiteModel.h
//  AutoParts
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SiteModel : NSObject


/**每个地方的id*/
@property (nonatomic, assign) int  siteId;

/**父级id*/
@property (nonatomic, assign) int  parentId;

/**地方的名称*/
@property (nonatomic, copy) NSString *siteName;

/**子节点*/
@property (nonatomic, strong) NSMutableArray *children;

/**是否展开标志*/
@property(nonatomic,assign) BOOL unfold;



@end
