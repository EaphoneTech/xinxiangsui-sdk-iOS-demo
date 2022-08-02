//
//  YFDeviceAPIHelpers.h
//  EphoneSDK
//
//  Created by 王丽珍 on 2021/11/3.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface YFDeviceAPIHelpers : NSObject

/// 获取accessToken接口
/// @param appid  心相随云平台生成的appid
/// @param secret  心相随云平台生成的secret
/// @param grantType  固定为client_credential
/// @param success  成功回调
/// @param failure 失败回调
+ (void)YFGetAccessTokenWithAppid:(NSString *)appid secret:(NSString *)secret grantType:(nullable NSString *)grantType success:(YFRequestSuccessBlock)success failure:(YFRequestFailureBlock)failure;


/// 查看设备最新的健康数据分析结果接口
/// @param accessToken 令牌
/// @param deviceid 设备id
/// @param success  成功回调
/// @param failure 失败回调
+ (void)YFLastOfDeviceDataWithAccessToken:(NSString *)accessToken deviceid:(NSString *)deviceid success:(YFRequestSuccessBlock)success failure:(YFRequestFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
