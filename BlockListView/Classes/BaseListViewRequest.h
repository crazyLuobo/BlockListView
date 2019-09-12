//
//  BaseListViewRequest.h
//  ListViewTryy
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 iOS002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PPNetworkHelper/PPNetworkHelper.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    RequestMethodTypeGet = 0,
    RequestMethodTypePost,
} RequestMethodType;
@interface BaseListViewRequest : NSObject
@property (nonatomic, strong) NSDictionary *requestDict;
@property (nonatomic, copy) NSString *requestString;
@property (nonatomic, copy) NSString *methodType;
@property (nonatomic, assign) BOOL isNeedCacheData;

+ (void)loadDataWithMethod:(RequestMethodType)methodType
            withRequestUrl:(NSString *)requestUrl
            withRequestParameters:(id)parameters
            withIsNeedCacheData:(BOOL)isNeedCache  responseCache:(PPHttpRequestCache)responseCache
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure ;


@end

NS_ASSUME_NONNULL_END
