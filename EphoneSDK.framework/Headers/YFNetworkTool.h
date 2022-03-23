//
//  YFNetworkTool.h
//  SeatCushion
//
//  Created by 王丽珍 on 2020/5/19.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

/**
网路请求成功回调

@param responseObject data
*/
typedef void(^YFRequestSuccessBlock)(id responseObject);

/**
网路请求失败回调

@param error 错误对象
@param errorDes 错误原因
*/
typedef void(^YFRequestFailureBlock)(NSError *error, NSString *errorDes);

@interface YFNetworkTool : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

+(instancetype)shareTool;


@end

