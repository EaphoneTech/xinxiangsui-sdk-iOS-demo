//
//  YFConnectDeviceFailController.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/12.
//  Copyright © 2020 王丽珍. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface YFConnectDeviceFailController : UIViewController

@property (nonatomic, assign) BOOL isWifiPwdError;  //Wi-Fi密码错误
@property (nonatomic, strong) NSString *bindErrorString;  //绑定设备失败原因


@end

NS_ASSUME_NONNULL_END
