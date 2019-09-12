//
//  BaseListViewConfig.h
//  ListViewTryy
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 iOS002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseListViewConfig : NSObject
@property (nonatomic, assign) BOOL isCanScorll;// 是否可以滑动
@property (nonatomic, assign) BOOL isNeedFreash;// 是否可以刷新
@property (nonatomic, assign) BOOL isNeedDelete;// 是否使用左滑删除
@property (nonatomic, assign) BOOL isUseSimpleRefresh;// 是否是简单的刷新
@property (nonatomic, assign) BOOL isNeedCacheData; // 请求的数据是否需要缓存
@property (nonatomic, assign) UITableViewStyle tableViewStyle;// 展示tableView的样式
@end

NS_ASSUME_NONNULL_END
