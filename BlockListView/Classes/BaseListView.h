//
//  BaseListView.h
//  LianHuiYi
//
//  Created by xiaoluobo on 2018/11/24.
//  Copyright © 2018年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseListViewBlockAPI.h"
#import "BaseListViewConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseListView : UIView
@property (nonatomic, strong) UITableView *baseTableView;
@property (nonatomic, assign) UIEdgeInsets separatorInset;//设置下滑线
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, copy) NumberOfSectionsBlock numberOfSectionsBlock;
@property (nonatomic, copy) ViewForHeaderInSection viewForHeaderInSection;
@property (nonatomic, copy) HeightForHeaderInSection heightForHeaderInSection;
@property (nonatomic, copy) ViewForFooterInSectionBlock viewForFooterInSection;
@property (nonatomic, copy) HeightForFooterInSectionBlock heightForFooterInSection;
@property (nonatomic, copy) NumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property (nonatomic, copy) CellForRowAtIndexPathBlock cellForRowAtIndexPathBlock;
@property (nonatomic, copy) HeightForRowAtIndexPathBlock heightForRowAtIndexPathBlock;
@property (nonatomic, copy) DidSelectRowAtIndexPathBlock didSelectRowAtIndexPathBlock;
@property (nonatomic, copy) DidSelectRowAtIndexPathBlock deleteRowAtIndexPathBlock;
@property (nonatomic, copy) ReturnTableViewSizeWithNoScroll returnTableViewSizeBlock;
@property (nonatomic, copy) TableViewDidScroll tableViewDidScroll;
@property (nonatomic, copy) TableViewRefresh tableViewRefresh;//
@property (nonatomic, copy) SetRequestDictBlock requestSetBlock;
@property (nonatomic, copy) SetReturnResponseBlock responseSetBlock;
@property (nonatomic, copy) ReturnResponseBlock dealResponseResultBlock;

- (instancetype)initWithFrame:(CGRect)frame withStyle:(UITableViewStyle)style;
- (instancetype)initWithFrame:(CGRect)frame WithListViewConfig:(BaseListViewConfig *)config;

#pragma mark - 直接赋值使用
// 这个是只有一个section的tableView调用
- (void)loadDataToTableViewWithArray:(NSArray *)contentArray;
// 这个是有section的tableView。并且sectionContentArray必须是数组套数组的json的数据类型
- (void)loadDataToTableViewWithSectionArray:(NSArray *)sectionContentArray;
// 不可滑动的时候返回高度
- (void)setFrameHeight:(CGFloat)height;
//删除
- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 网络请求使用
- (void)loadDataWithRequest:(NSString *)request withRequestDict:(NSDictionary *)requestDict  withModelClass:(NSString *)modelClass;

- (void)loadDataWithMethod:(NSString *)method withRequest:(NSString *)request withRequestDict:(NSDictionary *)requestDict withModelClass:(NSString *)modelClass;
#pragma mark 停止刷新
-(void)endRefresh;

@end

NS_ASSUME_NONNULL_END
