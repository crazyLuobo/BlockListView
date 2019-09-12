//
//  BaseListView.m
//  LianHuiYi
//
//  Created by xiaoluobo on 2018/11/24.
//  Copyright © 2018年 . All rights reserved.
//

#import "BaseListView.h"
#import "MJRefresh.h"
#import "BaseListViewRequest.h"

@interface BaseListView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *sectionContentArray;
@property (nonatomic, strong) NSDictionary *requestDict;
@property (nonatomic, copy) NSString *requestString;
@property (nonatomic, copy) NSString *methodType;
@property (nonatomic, copy) NSString *modelClassStr;
@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) int pageSize;
@property (nonatomic, assign) int totalCount;
@property (nonatomic, assign) BOOL isCanScorll;
@property (nonatomic, assign) BOOL isNeedFreash;
@property (nonatomic, assign) BOOL isNeedDelete;// 是否使用左滑删除
@property (nonatomic, assign) BOOL isUseSimpleRefresh;
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;//

@property (nonatomic, strong) BaseListViewConfig *config;




@end
@implementation BaseListView



- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = [[BaseListViewConfig alloc] init];
        [self initOriginConfig];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame WithListViewConfig:(BaseListViewConfig *)config
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = config;
        [self initOriginConfig];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withStyle:(UITableViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.config = [[BaseListViewConfig alloc] init];
        self.config.tableViewStyle = style;
        [self initOriginConfig];
    }
    return self;
}

- (void)initOriginConfig
{
     self.tableViewStyle = self.config.tableViewStyle;
    [self layoutBaseListView];
    self.isNeedFreash = self.config.isNeedFreash;
    self.isCanScorll = self.config.isCanScorll;
    self.isNeedDelete = self.config.isNeedDelete;
    self.isUseSimpleRefresh = self.config.isUseSimpleRefresh;
}

- (void)loadDataToTableViewWithArray:(NSArray *)contentArray
{
    self.contentArray = [NSMutableArray arrayWithArray:contentArray];
    [self refreshBaseListView];
}

- (void)loadDataToTableViewWithSectionArray:(NSArray *)sectionContentArray
{
    self.sectionContentArray = [NSArray arrayWithArray:sectionContentArray];
    [self refreshBaseListView];
}

- (void)refreshBaseListView
{
    [self.baseTableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.isCanScorll) {
            if (self.returnTableViewSizeBlock) {
                self.returnTableViewSizeBlock(self.baseTableView.contentSize);
            }
        }
    });
}

- (void)layoutBaseListView
{
    [self addSubview:self.baseTableView];
}

- (void)setIsCanScorll:(BOOL)isCanScorll
{
    _isCanScorll  = isCanScorll;
    if (isCanScorll == NO) {
        self.isNeedFreash = NO;
    }
    self.baseTableView.scrollEnabled = isCanScorll;
}

- (void)setIsNeedFreash:(BOOL)isNeedFreash
{
    _isNeedFreash = isNeedFreash;
    self.baseTableView.mj_header = _isNeedFreash ?[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)]:nil;
    //默认【上拉加载】
    self.baseTableView.mj_footer = _isNeedFreash ?[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)]:nil;
}

-(void)refresh
{
    NSLog(@"刷新了啊啊");
    if (self.isUseSimpleRefresh) {
          [self refreshWithIsMore:NO];
    }
    if (self.tableViewRefresh) {
        self.tableViewRefresh(YES);
    }
}

-(void)loadMore
{
    NSLog(@"刷新了啊啊");
    if (self.isUseSimpleRefresh) {
         [self refreshWithIsMore:YES];
    }
    if (self.tableViewRefresh) {
        self.tableViewRefresh(NO);
    }
}

#pragma mark 停止刷新
-(void)endRefresh
{
    if ([self.baseTableView.mj_header isRefreshing]) {
        [self.baseTableView.mj_header endRefreshing];
    }
    if ([self.baseTableView.mj_footer isRefreshing]) {
        [self.baseTableView.mj_footer endRefreshing];
    }
}

- (void)setFrameHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
    CGRect frame = self.bounds;
    self.baseTableView.frame= frame;;
}


- (void)loadDataWithRequest:(NSString *)request withRequestDict:(NSDictionary *)requestDict withModelClass:(NSString *)modelClass
{
    
    self.requestString = request;
    self.requestDict = requestDict;
    self.modelClassStr = modelClass;
    self.currentPage = 1;
    self.pageSize = 15;
    [self refreshWithIsMore:NO];
   
}



- (void)loadDataWithRequest:(NSString *)request withRequestDict:(NSDictionary *)requestDict withModelClass:(NSString *)modelClass withRequestBlock:(SetRequestDictBlock)requestBlock withReponseBlock:(SetReturnResponseBlock)response
{
    self.requestString = request;
    self.requestDict = requestDict;
    self.modelClassStr = modelClass;
    self.currentPage = 1;
    self.pageSize = 15;
    [self refreshWithIsMore:NO];
}

- (void)loadDataWithMethod:(NSString *)method  withRequest:(NSString *)request withRequestDict:(NSDictionary *)requestDict withModelClass:(NSString *)modelClass
{
    self.methodType = method;
    self.requestString = request;
    self.requestDict = requestDict;
    self.modelClassStr = modelClass;
    self.currentPage = 1;
    self.pageSize = 5;
    [self refreshWithIsMore:NO];
}



- (void)refreshWithIsMore:(BOOL)isMore 
{
    NSMutableDictionary *requestDict = [NSMutableDictionary dictionaryWithDictionary:self.requestDict];
    if (isMore == NO) {
        self.currentPage = 1;
        if (self.contentArray.count > 0) {
            [self.contentArray removeAllObjects];
        }
    }else{
        if (self.baseTableView.mj_footer.state == MJRefreshStateNoMoreData) {
            return;
        }
    }
    
    if (self.requestSetBlock) {
        [requestDict addEntriesFromDictionary:self.requestSetBlock(self.currentPage,self.pageSize)];
    }
    
    NSLog(@"请求接口参数 %@",requestDict);
    __weak BaseListView *weakSelf = self;
    [BaseListViewRequest loadDataWithMethod:RequestMethodTypeGet withRequestUrl:self.requestString withRequestParameters:requestDict withIsNeedCacheData:self.config.isNeedCacheData responseCache:^(id responseCache) {
    } success:^(id responseObject) {// 请求成功
         [weakSelf endRefresh];
        if (self.dealResponseResultBlock) {
            BaseListViewResponse *responseResult = weakSelf.dealResponseResultBlock(responseObject);
            [weakSelf dealResultWithResponseResult:responseResult withIsMore:isMore];

        }
       
    } failure:^(NSError *error) {// 请求失败
        [weakSelf endRefresh];
    }];
}

- (void)dealResultWithResponseResult:(BaseListViewResponse *)responseResult withIsMore:(BOOL)isMore
{
    [self endRefresh];
    if (responseResult.resultType == ResponseResultTypeSuccess) {// 将成功处理完成的加入数组中
            NSArray *contentArray = responseResult.resultArray;
            if (contentArray.count == 0 &&self.contentArray.count > 0) {
            
                [self.baseTableView.mj_footer endRefreshingWithNoMoreData];
            
                    return;
                }else{
                    self.baseTableView.mj_footer.state = MJRefreshStateIdle;
                }
              NSMutableArray *showArray = [NSMutableArray array];
            if (contentArray.count > 0) {
                self.currentPage += 1;
                if (isMore) {
                    if (self.contentArray.count > 0) {
                        [self.contentArray addObjectsFromArray:contentArray];
                    }else{
                        self.contentArray = [NSMutableArray arrayWithArray:contentArray];
                    }
                }else{
                     self.contentArray = [NSMutableArray arrayWithArray:contentArray];
                }
             }
        [self.baseTableView reloadData];
    }else{// 失败后处理
        
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.numberOfSectionsBlock) {
       return self.numberOfSectionsBlock(tableView);
    } else if(self.sectionContentArray.count > 0 && [self.sectionContentArray[0] isKindOfClass:[NSArray class]]){// 判断是是否为数组并且他的子类是数组
        return self.sectionContentArray.count;
    }else if(self.contentArray.count > 0){
        if (self.tableViewStyle == UITableViewStyleGrouped) {
            return self.contentArray.count;
        }
        return 1;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.viewForHeaderInSection) {
       return  self.viewForHeaderInSection(tableView, section);
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.viewForFooterInSection) {
      return  self.viewForFooterInSection(tableView, section);
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.heightForFooterInSection) {
       return  self.heightForFooterInSection(tableView, section);
    }else{
        return 0;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.viewForHeaderInSection) {
       return self.heightForHeaderInSection(tableView, section);
    }else{
        return 0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.numberOfRowsInSectionBlock) {
       return self.numberOfRowsInSectionBlock(tableView, section);
    }else if(self.sectionContentArray.count > 0 && [self.sectionContentArray[section] isKindOfClass:[NSArray class]]){
        return  [self.sectionContentArray[section] count];
    }else if(self.contentArray.count > 0){
        if (self.tableViewStyle == UITableViewStyleGrouped) {
            return 1;
        }
        return self.contentArray.count;
    }
    else{
        return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.cellForRowAtIndexPathBlock) {
        NSArray *contentArray;
        if(self.sectionContentArray.count > 0 && [self.sectionContentArray[0] isKindOfClass:[NSArray class]]){// 判断是是否为数组并且他的子类是数组
            contentArray = [NSArray arrayWithArray:self.sectionContentArray[indexPath.section]];;
        }else if (self.tableViewStyle == UITableViewStyleGrouped) {
            contentArray = [NSArray arrayWithObject:[self.contentArray objectAtIndex:indexPath.section]];
        } else if(self.contentArray.count > 0){
            contentArray = [NSArray arrayWithArray:self.contentArray];
        }else {
            return nil;
        }
       return self.cellForRowAtIndexPathBlock(tableView, indexPath,contentArray);
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.heightForRowAtIndexPathBlock) {
        NSArray *contentArray;
        if(self.sectionContentArray.count > 0 && [self.sectionContentArray[0] isKindOfClass:[NSArray class]]){// 判断是是否为数组并且他的子类是数组
            contentArray = [NSArray arrayWithArray:self.sectionContentArray[indexPath.section]];;
        }
        else if(self.contentArray.count > 0){
            if (self.tableViewStyle == UITableViewStyleGrouped) {
                contentArray = [NSArray arrayWithObject:[self.contentArray objectAtIndex:indexPath.section]];
                
            }else {
                contentArray = [NSArray arrayWithArray:self.contentArray];
            }
        }
       return  self.heightForRowAtIndexPathBlock(tableView, indexPath,contentArray);
    }else{
        return 0;
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectRowAtIndexPathBlock) {
        NSArray *contentArray;
        if(self.sectionContentArray.count > 0 && [self.sectionContentArray[0] isKindOfClass:[NSArray class]]){// 判断是是否为数组并且他的子类是数组
            contentArray = [NSArray arrayWithArray:self.sectionContentArray[indexPath.section]];;
        }else if (self.tableViewStyle == UITableViewStyleGrouped) {
            contentArray = [NSArray arrayWithObject:[self.contentArray objectAtIndex:indexPath.section]];
        }else if(self.contentArray.count > 0){
            contentArray = [NSArray arrayWithArray:self.contentArray];
        }
        self.didSelectRowAtIndexPathBlock(tableView, indexPath,contentArray);
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.isNeedDelete;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.deleteRowAtIndexPathBlock) {
        NSArray *contentArray;
        if(self.sectionContentArray.count > 0 && [self.sectionContentArray[0] isKindOfClass:[NSArray class]]){// 判断是是否为数组并且他的子类是数组
            contentArray = [NSArray arrayWithArray:self.sectionContentArray[indexPath.section]];
        }else if (self.tableViewStyle == UITableViewStyleGrouped) {
            contentArray = [NSArray arrayWithObject:[self.contentArray objectAtIndex:indexPath.section]];
        }else if(self.contentArray.count > 0){
            contentArray = [NSArray arrayWithArray:self.contentArray];
        }
        self.deleteRowAtIndexPathBlock(tableView, indexPath, contentArray);
    }
    
}

-(void)deleteRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewStyle == UITableViewStyleGrouped) {
        id obj = [self.contentArray objectAtIndex:indexPath.section];
        [self.contentArray removeObject:obj];
    }else {
        id obj = [self.contentArray objectAtIndex:indexPath.row];
        [self.contentArray removeObject:obj];
    }
    [self.baseTableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
     if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows]lastObject]).row){
         if (!self.isCanScorll) {
             if (self.returnTableViewSizeBlock) {
                 self.returnTableViewSizeBlock(self.baseTableView.contentSize);
             }
         }
     }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.tableViewDidScroll) {
        self.tableViewDidScroll(self.baseTableView);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
     return @"删除";
}

- (UITableView *)baseTableView
{
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:self.bounds style:self.tableViewStyle];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _baseTableView;
}

-(void)setSeparatorInset:(UIEdgeInsets)separatorInset
{
    _separatorInset = separatorInset;
    if (UIEdgeInsetsEqualToEdgeInsets(separatorInset, UIEdgeInsetsZero)) {
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else {
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _baseTableView.separatorInset = separatorInset;
    }
}

- (UIView *)noDataView
{
    if (!_noDataView) {
         _noDataView = [[UIView alloc] initWithFrame:self.bounds];
    }
    return _noDataView;
}

@end
