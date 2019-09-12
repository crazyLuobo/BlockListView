//
//  BaseListViewBlockAPI.h
//  ListViewTryy
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 iOS002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseListViewResponse.h"

NS_ASSUME_NONNULL_BEGIN
// tableView通用block
typedef NSInteger(^NumberOfSectionsBlock)(UITableView *tableView);
typedef UIView *_Nullable(^ViewForHeaderInSection)(UITableView *tableView,NSInteger section);
typedef CGFloat(^HeightForHeaderInSection)(UITableView *tableView,NSInteger section);

typedef NSInteger(^NumberOfRowsInSectionBlock)(UITableView *tableView,NSInteger section);
typedef UITableViewCell* _Nullable (^CellForRowAtIndexPathBlock)(UITableView *tableView,NSIndexPath * indexPath,NSArray *contentArray);
typedef CGFloat (^HeightForRowAtIndexPathBlock)(UITableView *tableView,NSIndexPath * indexPath,NSArray *contentArray);
typedef void (^DidSelectRowAtIndexPathBlock)(UITableView *tableView,NSIndexPath * indexPath,NSArray *contentArray);

typedef void(^ReturnTableViewSizeWithNoScroll)(CGSize size);

typedef void(^TableViewDidScroll)(UITableView *tableView);
typedef void(^TableViewRefresh)(BOOL isHeader);

typedef NSDictionary *_Nonnull(^SetRequestDictBlock)(int currentPage,int pageSize);
typedef NSArray *_Nullable(^SetReturnResponseBlock)(NSDictionary *response,NSArray *contentArray,BOOL isMore);

typedef CGFloat (^HeightForFooterInSectionBlock)(UITableView *tableView,NSInteger section);
typedef UIView *_Nullable(^ViewForFooterInSectionBlock)(UITableView *tableView,NSInteger section);

typedef BaseListViewResponse *_Nullable(^ReturnResponseBlock)(id response);


// collectionView通用block


@interface BaseListViewBlockAPI : NSObject

@end

NS_ASSUME_NONNULL_END
