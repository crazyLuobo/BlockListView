//
//  BaseListViewConfig.m
//  ListViewTryy
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 iOS002. All rights reserved.
//

#import "BaseListViewConfig.h"

@implementation BaseListViewConfig
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNeedFreash = NO;
        self.isCanScorll =  YES;
        self.isNeedDelete = NO;
        self.isUseSimpleRefresh = YES;
        self.tableViewStyle = UITableViewStylePlain;
        self.isNeedCacheData = NO;
    }
    return self;
}
@end
