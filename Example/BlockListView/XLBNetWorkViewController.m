//
//  XLBNetWorkViewController.m
//  BlockListView_Example
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 yanwenbo_78201@163.com. All rights reserved.
//

#import "XLBNetWorkViewController.h"
#import "BaseListView.h"
@interface XLBNetWorkViewController ()
@property (nonatomic, strong) BaseListView *contentListView;
@end

@implementation XLBNetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"网络页面";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentListView];
    
    [self.contentListView loadDataWithMethod:@"" withRequest:@"http://lianhuiyi.woneast.com/lhy/v0.1/api/place" withRequestDict:@{@"cityCode":@"100000"} withModelClass:@""];
}

- (BaseListView *)contentListView
{
    if (!_contentListView) {
        BaseListViewConfig *config = [[BaseListViewConfig alloc] init];
        config.isNeedDelete = YES;
        config.isNeedFreash = YES;
        __weak XLBNetWorkViewController *weakSelf = self;
        _contentListView = [[BaseListView alloc] initWithFrame:self.view.bounds WithListViewConfig:config];
        _contentListView.requestSetBlock = ^NSDictionary * _Nonnull(int currentPage, int pageSize) {
            NSDictionary *dict = @{@"pageNum":[NSString stringWithFormat:@"%d",currentPage],
                                   @"pageSize":[NSString stringWithFormat:@"%d",pageSize]
                                   };
            return dict;
            
        };
        _contentListView.dealResponseResultBlock = ^BaseListViewResponse * _Nullable(id  _Nonnull response) {
            BaseListViewResponse *responseResult = [[BaseListViewResponse alloc] init];
            NSDictionary *responseDict = [NSDictionary dictionaryWithDictionary:response];
            if ([[responseDict objectForKey:@"code"] intValue] == 200) {
                NSDictionary *data = [NSDictionary dictionaryWithDictionary:[responseDict objectForKey:@"data"]];
                responseResult.resultType = ResponseResultTypeSuccess;
                responseResult.resultArray = [NSArray arrayWithArray:[data objectForKey:@"data"]];
            }else{
                responseResult.resultType = ResponseResultTypeFailture;
            }
            
            return responseResult;
        };
        
        _contentListView.heightForRowAtIndexPathBlock = ^CGFloat(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSArray * _Nonnull contentArray) {
            return 100;
        };
        
        _contentListView.cellForRowAtIndexPathBlock = ^UITableViewCell * _Nullable(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSArray * _Nonnull contentArray) {
            static NSString *indifier = @"UITableViewCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indifier];
            }
            NSDictionary *infoDict = [contentArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [infoDict objectForKey:@"name"];
            return cell;
            
        };
        
        _contentListView.didSelectRowAtIndexPathBlock = ^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, NSArray * _Nonnull contentArray) {
            [weakSelf.navigationController pushViewController:[XLBNetWorkViewController new] animated:YES];
        };
        
        
    }
    return _contentListView;
}


@end
