//
//  YFBluetooth.h
//  EphoneSDK
//
//  Created by 王丽珍 on 2021/11/11.
//

#import <Foundation/Foundation.h>

@protocol YFBluetoothDelegate;

@interface YFBluetooth : NSObject

@property (nonatomic, weak) id <YFBluetoothDelegate> delegate;

@end

@protocol YFBluetoothDelegate <NSObject>

@optional


/// 扫描到的所有设备（设备有重复）
/// @param peripheral 扫描到的设备
- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral;


/// 扫描到的设备(无重复设备)
/// @param peripheral 扫描到的设备
- (void)didScanDevicesPeripheral:(CBPeripheral *)peripheral;


/// 设备连接成功 -- 蓝牙
/// @param peripheral 连接成功设备
- (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral;


/// 设备连接失败 -- 蓝牙
/// @param peripheral 连接失败设备
- (void)didConnectFailPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;

/// 设备连接断开
/// @param peripheral 连接失败的设备
- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;


/// 配网成功
/// @param peripheral 配网成功的设备
- (void)didSuccessToConnectToInternet:(CBPeripheral *)peripheral;

/// 配网失败
/// @param error 失败原因   枚举待定
- (void)didFailToConnectToInternet:(NSString *)error;


/// 实时波形数据 --- ECG
/// @param array ECG实时数据
- (void)bluetoothECGWaveData:(NSMutableArray *)array;


/// 实时波形数据 --- ECG、PPG红光数据、PPG红外数据
/// @param ECGArray ECG数据
/// @param PPGRedLightArray PPG红光数据
/// @param PPGInfraredArray PPG红外数据
- (void)bluetoothAllWaveECG:(NSMutableArray *)ECGArray PPGRedLight:(NSMutableArray *)PPGRedLightArray PPGInfrared:(NSMutableArray *)PPGInfraredArray;

/// 心率
/// @param heartRate 心率
- (void)bluetoothHeartRate: (long)heartRate;


/// ECG信号采集状态
/// @param signalStatus  YES：信号良好， NO：信号不佳 或 采集不到信号
- (void)ECGSignalStatus:(BOOL)signalStatus;


/// PPG信号采集状态
/// @param signalStatus  YES：信号良好， NO：信号不佳 或 采集不到信号
- (void)PPGSignalStatus:(BOOL)signalStatus;


/// 设备监测时长  单位为秒
/// @param monitoringTime  监测时长
- (void)monitoringDurationOfTheDevice:(long)monitoringTime;

/// 是否离座
/// @param isLeaveSeat 离座状态：YES， 离座 NO：未离座
- (void)deviceStatusOfLeaveSeat:(BOOL)isLeaveSeat;


/// 蓝牙状态更新
/// @param peripheralState  CBManager的当前状态
- (void)bluetoothDidUpdateState:(CBManagerState)peripheralState;


@end
