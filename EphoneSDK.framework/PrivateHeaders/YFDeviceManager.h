//
//  YFDeviceManager.h
//  EphoneSDK
//
//  Created by 王丽珍 on 2021/11/3.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YFDeviceBindStatus) {
    YFDeviceBindStatusNone,    // 未被绑定
    YFDeviceBindStatusOneself,  //被自己绑定
    YFDeviceBindStatusOthers,    // 被其他人绑定
    YFDeviceBindStatusNotExist  //不存在
};

NS_ASSUME_NONNULL_BEGIN

@interface YFDeviceManager : NSObject

//@property (readonly, nonatomic, assign) YFDeviceBindStatus bindStatus;


@end

NS_ASSUME_NONNULL_END
