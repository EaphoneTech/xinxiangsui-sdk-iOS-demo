//
//  YFDeviceAPIHelpers.h
//  EphoneSDK
//
//  Created by 王丽珍 on 2021/11/3.
//

#import <Foundation/Foundation.h>
#import "YFNetworkTool.h"


NS_ASSUME_NONNULL_BEGIN

@interface YFDeviceAPIHelpers : NSObject

/// 根据序列号查询产品
/// @param serialNumber 设备条形码
/// @param success  成功回调 （bind_status：设备绑定状态，0:未被绑定，1:已被自己绑定 2:已被其他人绑定）
/// @param failure 失败回调  （错误码：  21:对应序列号设备不存在）
+ (void)YFGetProductBySerialNumber:(NSString *)serialNumber success:(YFRequestSuccessBlock)success failure:(YFRequestFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
