# 心相随设备配网SDK demo
# ===========================
 
## 功能简介：
   心相随SDK功能实现，包括扫描获取外围设备，连接设备，实现蓝牙配网，扫描读取特征服务，获取实时波形数据及相关状态数据等。
   
## 实现方法：
### 2. 调用单例方法，扫描获取设备列表，读取设备服务

``` 
- (void)scanPeripheral;  //扫描外围设备
``` 

 ``` 
- (void)stopScanPeripheral;   //停止扫描设备
``` 

 ``` 
 - (void)connectPeripheral:(CBPeripheral *)peripheral;    // 连接设备
 ``` 

``` 
- (void)cancelPeripheralConnection;     // 取消连接设备
``` 

``` 
- (void)DiscoverServices;     // 获取设备中的服务
``` 



### 2. YFBluetoothDelegate代理方法回调

``` 
- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral;   // 扫描到的所有设备（设备有重复）
``` 

``` 
- (void)didScanDevicesPeripheral:(CBPeripheral *)peripheral;   // 扫描到的设备(无重复设备)
``` 

``` 
- (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral;     // 设备连接成功
``` 

``` 
- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral;    // 设备连接断开
``` 

``` 
- (void)didSuccessToConnectToInternet:(CBPeripheral *)peripheral;    // 配网成功
``` 

``` 
- (void)didFailToConnectToInternet:(NSString *)error;    // 配网失败
``` 

``` 
- (void)bluetoothECGWaveData:(NSMutableArray *)array;    // 实时波形数据 --- ECG
``` 

``` 
- (void)bluetoothAllWaveECG:(NSMutableArray *)ECGArray PPGRedLight:(NSMutableArray *)PPGRedLightArray PPGInfrared:(NSMutableArray *)PPGInfraredArray;    // 实时波形数据 --- ECG、PPG红光数据、PPG红外数据
``` 

``` 
- (void)bluetoothHeartRate: (long)heartRate;    // 心率
``` 

``` 
- (void)ECGSignalStatus:(BOOL)signalStatus;    // ECG信号采集状态, YES：信号良好， NO：信号不佳 或 采集不到信号
``` 

``` 
- (void)PPGSignalStatus:(BOOL)signalStatus;    // PPG信号采集状态  YES：信号良好， NO：信号不佳 或 采集不到信号
``` 

``` 
- (void)monitoringDurationOfTheDevice:(long)monitoringTime;   // 设备监测时长  单位为秒
``` 

``` 
- (void)deviceStatusOfLeaveSeat:(BOOL)isLeaveSeat;   //是否离座  YES，离座  NO：未离座
``` 

``` 
- (void)bluetoothDidUpdateState:(CBManagerState)peripheralState;   // 蓝牙状态
``` 

   



