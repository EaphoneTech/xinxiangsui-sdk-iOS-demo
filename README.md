# 心相随设备配网SDK demo
# ===========================

## 功能简介：
   心相随SDK功能实现，包括扫描获取外围设备，连接设备，实现蓝牙配网，扫描读取特征服务，获取实时波形数据及相关状态数据等。
   
## 实现方法：
>1. 调用单例方法，扫描获取设备列表，读取设备服务

>> /// 扫描外围设备
``` 
- (void)scanPeripheral;
``` 

 >>/// 停止扫描设备
 ``` 
- (void)stopScanPeripheral;
``` 

 /// 连接设备
 /// @param peripheral CBPeripheral
 ``` 
 - (void)connectPeripheral:(CBPeripheral *)peripheral;
 ``` 

/// 取消连接设备
``` 
- (void)cancelPeripheralConnection;
``` 

/// 获取设备中的服务
``` 
- (void)DiscoverServices;
``` 



### 2. YFBluetoothDelegate代理方法回调

/// 扫描到的所有设备（设备有重复）
/// @param peripheral 扫描到的设备
``` 
- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral;
``` 

/// 扫描到的设备(无重复设备)
/// @param peripheral 扫描到的设备
``` 
- (void)didScanDevicesPeripheral:(CBPeripheral *)peripheral;
``` 


/// 设备连接成功
/// @param peripheral 连接成功设备
``` 
- (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral;
``` 

/// 设备连接断开
/// @param peripheral 连接失败的设备
``` 
- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral;
``` 


/// 配网成功
/// @param peripheral 配网成功的设备
``` 
- (void)didSuccessToConnectToInternet:(CBPeripheral *)peripheral;
``` 

/// 配网失败
/// @param error 失败原因   枚举待定
``` 
- (void)didFailToConnectToInternet:(NSString *)error;
``` 


/// 实时波形数据 --- ECG
/// @param array ECG实时数据
``` 
- (void)bluetoothECGWaveData:(NSMutableArray *)array;
``` 


/// 实时波形数据 --- ECG、PPG红光数据、PPG红外数据
/// @param ECGArray ECG数据
/// @param PPGRedLightArray PPG红光数据
/// @param PPGInfraredArray PPG红外数据
``` 
- (void)bluetoothAllWaveECG:(NSMutableArray *)ECGArray PPGRedLight:(NSMutableArray *)PPGRedLightArray PPGInfrared:(NSMutableArray *)PPGInfraredArray;
``` 


/// 心率
/// @param heartRate 心率
``` 
- (void)bluetoothHeartRate: (long)heartRate;
``` 


/// ECG信号采集状态
/// @param signalStatus  YES：信号良好， NO：信号不佳 或 采集不到信号
``` 
- (void)ECGSignalStatus:(BOOL)signalStatus;
``` 


/// PPG信号采集状态
/// @param signalStatus  YES：信号良好， NO：信号不佳 或 采集不到信号
``` 
- (void)PPGSignalStatus:(BOOL)signalStatus;
``` 


/// 设备监测时长  单位为秒
/// @param monitoringTime  监测时长
``` 
- (void)monitoringDurationOfTheDevice:(long)monitoringTime;
``` 


/// 是否离座
/// @param isLeaveSeat 离座状态：YES， 离座 NO：未离座
``` 
- (void)deviceStatusOfLeaveSeat:(BOOL)isLeaveSeat;
``` 


/// 蓝牙状态
/// @param peripheralState  CBManager的当前状态
``` 
- (void)bluetoothDidUpdateState:(CBManagerState)peripheralState;
``` 

   



