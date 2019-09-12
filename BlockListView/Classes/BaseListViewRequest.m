//
//  BaseListViewRequest.m
//  ListViewTryy
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 iOS002. All rights reserved.
//

#import "BaseListViewRequest.h"
@implementation BaseListViewRequest
+ (void)loadDataWithMethod:(RequestMethodType)methodType
            withRequestUrl:(NSString *)requestUrl
            withRequestParameters:(id)parameters
            withIsNeedCacheData:(BOOL)isNeedCache  responseCache:(PPHttpRequestCache)responseCache
                   success:(PPHttpRequestSuccess)success
                   failure:(PPHttpRequestFailed)failure
{
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [PPNetworkHelper GET:requestUrl parameters:parameters responseCache:^(id responseCache) {
                if (isNeedCache) {
                    
                }
            } success:^(id responseObject) {
                success(responseObject);
                
            } failure:^(NSError *error) {
                failure(error);
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
