//
//  YFBleManager.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/10/27.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

//@protocol YFBleManagerDelegate;

@interface YFBleManager : NSObject

/// 中心管理者(管理设备的扫描和连接)
@property (nonatomic, strong) CBCentralManager *centralManager;
/// 扫描到的设备
@property (nonatomic, strong) CBPeripheral *cbPeripheral;
/// 手机蓝牙状态
@property (nonatomic, assign) CBManagerState peripheralState;


/// Wi-Fi账号
@property (nonatomic, strong) NSString *SSID;
/// Wi-Fi密码
@property (nonatomic, strong) NSString *PASSWORD;

/// 是否有PPG信号  有YES：同时有ECG和PPG数据， 没有NO：仅有ECG数据
@property (nonatomic, assign) BOOL isHasPPG;


+ (instancetype)shareTool;

/// 扫描外围设备
- (void)scanPeripheral;

/// 停止扫描设备
- (void)stopScanPeripheral;

/// 连接设备
/// @param peripheral CBPeripheral
- (void)connectPeripheral:(CBPeripheral *)peripheral;


/// 取消连接设备
- (void)cancelPeripheralConnection;

/// 获取设备中的服务
- (void)DiscoverServices;


@end
