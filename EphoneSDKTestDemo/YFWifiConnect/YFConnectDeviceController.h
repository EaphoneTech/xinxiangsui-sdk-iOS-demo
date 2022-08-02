//
//  YFConnectDeviceController.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/12.
//  Copyright © 2020 王丽珍. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface YFConnectDeviceController : UIViewController


///wifi账号
@property(nonatomic,copy)NSString * ssidStr;
///密码
@property(nonatomic,copy)NSString * password;
///连接设备用的Bssid
@property(nonatomic,copy)NSString * connectBssid;
///条形码序列号
@property (nonatomic, strong) NSString *serialNumber;


@end

NS_ASSUME_NONNULL_END
