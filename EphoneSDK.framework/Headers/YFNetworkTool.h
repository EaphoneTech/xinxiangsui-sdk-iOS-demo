//
//  YFNetworkTool.h
//  SeatCushion
//
//  Created by 王丽珍 on 2020/5/19.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFNetworkDataModel.h"
#import <AFNetworking.h>

//NS_ASSUME_NONNULL_BEGIN


typedef void(^YFRequestSuccessBlock)(YFNetworkDataModel *responseModel);

/**
网路请求失败回调

@param error 错误对象
@param errorDes 错误原因
*/
typedef void(^YFRequestFailureBlock)(NSError *error, NSString *errorDes);

@interface YFNetworkTool : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

+(instancetype)shareTool;

/**
HTTP  POST网络请求

@param URLString 接口路径
@param parameters 接口参数
@param success 成功回调
@param failure 失败回调
*/
- (void)httpRequestPost:(NSString *)URLString parameters:(NSDictionary *)parameters success:(YFRequestSuccessBlock)success failure:(YFRequestFailureBlock)failure;

/**
 POST网络请求
 
 @param URLString 接口路径
 @param parameters 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
     success:(YFRequestSuccessBlock)success
     failure:(YFRequestFailureBlock)failure;

/**
 GET网络请求
 
 @param URLString 接口路径
 @param parameters 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(YFRequestSuccessBlock)success
    failure:(YFRequestFailureBlock)failure;

/**
 DELETE网络请求
 
 @param URLString 接口路径
 @param parameters 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)DELETE:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(YFRequestSuccessBlock)success
    failure:(YFRequestFailureBlock)failure;


/**
 PATCH网络请求
 
 @param URLString 接口路径
 @param parameters 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)PATCH:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(YFRequestSuccessBlock)success
    failure:(YFRequestFailureBlock)failure;


/**
 PUT网络请求
 
 @param URLString 接口路径
 @param parameters 接口参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)PUT:(NSString *)URLString
 parameters:(NSDictionary *)parameters
    success:(YFRequestSuccessBlock)success
    failure:(YFRequestFailureBlock)failure;

/**
 *  POST 表单上传网络请求
 *
 *  @param URLString  URLString
 *  @param parameters 请求体
 *  @param filesArray @[请求体]
 *  @param success    成功回调
 *  @param failure    失败回调
 */
-(void)POSTFile:(NSString *)URLString
     parameters:(NSDictionary *)parameters
          files:(NSArray *)filesArray
        success:(YFRequestSuccessBlock)success
        failure:(YFRequestFailureBlock)failure;


/**
 *  DOWNLOAD 请求
 *
 */
//-(void)DownLoadFile:(NSString *)URLString
//        success:(BLDownloadSuccessBlock)success
//        failure:(BLRequestFailureBlock)failure;

/**
 *取消当前请求队列的所有请求
 */
//- (void)cancelAllOperations;

/// 设置请求头
- (void)requestSerializer:(NSString *)token;

/// 置空请求头
- (void)setEmptyRequestSerializer;

@end

//NS_ASSUME_NONNULL_END
