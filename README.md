# 心相随设备配网SDK demo
 
## 功能简介：
   心相随SDK功能实现，包括扫描获取外围设备，连接设备，实现蓝牙配网，扫描读取特征服务，获取实时波形数据及相关状态数据等。
   
   
## 集成说明
1. 两种集成方式 

方式一：导入直接导入framework文件
```
将EphoneSDK.framework拷贝至项目根目录
//导入头文件
#import <EphoneSDK/EphoneSDK.h>
```
方式二：使用CocoaPods
```
pod 'XinxiangsuiSDK'
//导入头文件
#import <XinxiangsuiSDK/EphoneSDK.h>
```

2. info.plist中设定蓝牙访问权限、定位权限（用于获取Wi-Fi）
```
<key>NSBluetoothAlwaysUsageDescription</key>
<string>心相随需要访问您的蓝牙，用于您设备联网等功能</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>心相随需要访问您的蓝牙，用于您设备联网等功能</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>获取Wi-FI名称需要您的定位权限，以便帮助您配置设备</string>
```

3. 项目TARGETS
```
 Capability：添加Access WiFi Information
 Background Modes: 选择 Uses Bluetooth LE accessories、Background fetch
 ```


   
## 实现方法：
### 1. 单例类YFBleManager：调用单例方法，扫描获取设备列表，读取设备服务

|方法|参数|说明|
|-------------|:-------------:|-----|
| - (void)scanPeripheral                                 |---| 扫描外围设备 |
| - (void)stopScanPeripheral                             |---| 停止扫描设备 |
| - (void)connectPeripheral:(CBPeripheral *)peripheral   |CBPeripheral 要连接的设备，不可为空| 连接设备 |
| - (void)cancelPeripheralConnection                     |---| 取消连接设备 |



判断是否有PPG信号  有YES：同时有ECG和PPG数据， 没有NO：仅有ECG数据
```
@property (nonatomic, assign) BOOL isHasPPG
```

示例（扫描设备）：
```
[[YFBleManager shareTool] scanPeripheral];
```




### 2. YFBluetoothDelegate代理方法回调

#### 2.1 连接设备
|方法|参数|说明|
|-------------|:-------------:|-----|
| - (void)didScanDevicesPeripheral:(CBPeripheral *)peripheral                             |---| 获取扫描到的设备 |
| - (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral   || 设备连接成功 |
| - (void)didDisconnectPeripheral:(CBPeripheral *)peripheral                    |---| 设备连接断开 |
| - (void)didSuccessToConnectToInternet:(CBPeripheral *)peripheral                              |---| 设备配网成功 |
| - (void)didFailToConnectToInternet:(NSString *)error                               |---| 设备配网失败 |


#### 2.2 获取已连接设备实时数据
|方法|参数|说明|
|-------------|:-------------:|-----|
| - (void)bluetoothECGWaveData:(NSMutableArray *)array                            |---| 实时波形数据 --- ECG |
| - (void)bluetoothAllWaveECG:(NSMutableArray *)ECGArray PPGRedLight:(NSMutableArray *)PPGRedLightArray PPGInfrared:(NSMutableArray *)PPGInfraredArray  |ECGArray：ECG，PPGRedLightArray：PPG红光数据，PPGInfraredArray：PPG红外数据| 实时波形数据 --- ECG、PPG红光数据、PPG红外数据 |
| - (void)bluetoothHeartRate: (long)heartRate                   |---| 心率 |
| - (void)monitoringDurationOfTheDevice:(long)monitoringTime                            |monitoringTime：时长，单位为秒| 设备监测时长 |

说明：
```
if([YFBleManager shareTool].isHasPPG) {
   //调用 - (void)bluetoothAllWaveECG:(NSMutableArray *)ECGArray PPGRedLight:(NSMutableArray *)PPGRedLightArray PPGInfrared:(NSMutableArray *)PPGInfraredArray  
} else {
   //调用 - (void)bluetoothECGWaveData:(NSMutableArray *)array
}
```

#### 2.3 监测设备状态
|方法|参数|说明|
|-------------|:-------------:|-----|
| - (void)ECGSignalStatus:(BOOL)signalStatus                              |signalStatus  YES：信号良好， NO：信号不佳 或 采集不到信号| ECG信号采集状态 |
| - (void)PPGSignalStatus:(BOOL)signalStatus                  |signalStatus  YES：信号良好， NO：信号不佳 或 采集不到信号| PPG信号采集状态 |
| - (void)deviceStatusOfLeaveSeat:(BOOL)isLeaveSeat                |isLeaveSeat 离座状态：YES， 离座 NO：未离座  | 是否离座 |
  
  
## 文档
[com.芯相随.ephonesdk.EphoneSDK.docset.zip](https://github.com/wlz0610/EphoneSDKTestDemo/files/7553283/com.ephonesdk.EphoneSDK.docset.zip)
   
## 系统要求
该项目最低支持 iOS 10.0






