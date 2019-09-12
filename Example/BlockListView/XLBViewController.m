//
//  XLBViewController.m
//  BlockListView
//
//  Created by yanwenbo_78201@163.com on 09/12/2019.
//  Copyright (c) 2019 yanwenbo_78201@163.com. All rights reserved.
//

#import "XLBViewController.h"
#import "BaseListView.h"
#import "XLBNetWorkViewController.h"
@interface XLBViewController ()
@property (nonatomic, strong) BaseListView *contentListView;
@end

@implementation XLBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"简单数据页面展示";
    
    [self.view addSubview:self.contentListView];
    
    [self.contentListView loadDataToTableViewWithArray:@[@"获取网路数据不刷新",@"获取网路数据刷新",@"eeee",@"44444",@"55555"]];
}

- (BaseListView *)contentListView
{
    if (!_contentListView) {
        BaseListViewConfig *config = [[BaseListViewConfig alloc] init];
        config.isNeedDelete = YES;
        config.isNeedFreash = NO;
        __weak XLBViewController *weakSelf = self;
        _contentListView = [[BaseListView alloc] initWithFrame:self.view.bounds WithListViewConfig:config];
        
        _contentListView.heightForRowAtIndexPathBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSArray * _Nonnull contentArray) {
            return 100;
        };
        
        _contentListView.cellForRowAtIndexPathBlock = ^UITableViewCell * _Nullable(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSArray * _Nonnull contentArray) {
            static NSString *indifier = @"UITableViewCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indifier];
            }
            cell.textLabel.text = [contentArray objectAtIndex:indexPath.row];
            return cell;
            
        };
        
        _contentListView.didSelectRowAtIndexPathBlock = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSArray * _Nonnull contentArray) {
            [weakSelf.navigationController pushViewController:[XLBNetWorkViewController new] animated:YES];
        };
        
        
    }
    return _contentListView;
}


@end
