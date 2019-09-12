//
//  BaseListViewResponse.h
//  ListViewTryy
//
//  Created by iOS002 on 2019/9/12.
//  Copyright © 2019 iOS002. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ResponseResultTypeSuccess,
    ResponseResultTypeFailture,
} ResponseResultType;
@interface BaseListViewResponse : NSObject
@property (nonatomic, assign) ResponseResultType resultType;
@property (nonatomic, strong) NSArray *resultArray;
@end

NS_ASSUME_NONNULL_END
