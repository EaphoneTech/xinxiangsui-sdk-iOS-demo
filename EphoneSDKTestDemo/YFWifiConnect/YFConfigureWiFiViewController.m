//
//  YFConfigureWiFiViewController.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/12.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "YFConfigureWiFiViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "YFTextField.h"

#import "YFConnectDeviceController.h"

@interface YFConfigureWiFiViewController ()<CLLocationManagerDelegate, UITextFieldDelegate, YFBluetoothDelegate>

@property (nonatomic, strong) YFTextField *wifiField;

@property (nonatomic, strong) YFTextField *pwdField;

@property (nonatomic, strong) UIButton *addButton;


@property(nonatomic,strong) CLLocationManager* locationManager;

///wifi账号
@property(nonatomic,copy)NSString * ssidStr;
///BSSID
@property(nonatomic,copy)NSString * bssid;

//@property (nonatomic, strong) YFBluetooth *bluetooth;

@end

@implementation YFConfigureWiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"配置Wi-Fi网络";
    [self.view addSubview:self.wifiField];
    [self.view addSubview:self.pwdField];
    [self.view addSubview:self.addButton];
    
    [self getUserLocation];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
//    self.bluetooth = [[YFBluetooth alloc] init];
    
    [YFBleManager shareTool].bluetooth.delegate = self;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSDictionary *netInfo = [self currentWifiSSID];
    self.ssidStr = [netInfo objectForKey:@"SSID"];
    if (!self.ssidStr) {
        self.wifiField.placeholder = @"未连接到WiFi";
    }else{
        self.wifiField.text = [netInfo objectForKey:@"SSID"];
        
        self.bssid = [netInfo objectForKey:@"BSSID"];
    }
    
}


- (void)enterForeground{
    NSDictionary *netInfo = [self currentWifiSSID];
    self.ssidStr = [netInfo objectForKey:@"SSID"];
    if (!self.ssidStr) {
        self.wifiField.placeholder = @"未连接到WiFi";
    }else{
        self.wifiField.text = [netInfo objectForKey:@"SSID"];
        
        self.bssid = [netInfo objectForKey:@"BSSID"];
    }
    
}


- (void)getUserLocation{
    if (![self judgeUserLocationAuth]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
    }
}


- (BOOL)judgeUserLocationAuth {
    
    BOOL result = NO;

    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            break;
        case kCLAuthorizationStatusRestricted:
            break;
        case kCLAuthorizationStatusDenied:
        {
            [self BAAlertWithTitle:@"未授权获取位置信息" message:@"为获取到手机当前连接的WiFi信息，请在iOS的“设置-隐私-定位服务”开启定位服务，并允许心相随使用定位服务" andOthers:@[@"取消",@"去设置"] animated:YES action:^(NSInteger index) {
                if (index == 1) {
                    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        if (@available(iOS 10.0, *)) {
                            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
                        } else {
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }
                }
            }];
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            result = YES;
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            result = YES;
            break;
            
        default:
            break;
    }
    return result;
}



- (NSDictionary *)fetchNetInfo
{
    NSArray *interfaceNames = CFBridgingRelease(CNCopySupportedInterfaces());
    //    NSLog(@"%s: Supported interfaces: %@", __func__, interfaceNames);
    
    NSDictionary *SSIDInfo;
    for (NSString *interfaceName in interfaceNames) {
        SSIDInfo = CFBridgingRelease(
                                     CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName));
        //        NSLog(@"%s: %@ => %@", __func__, interfaceName, SSIDInfo);
        
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}

- (NSDictionary *)currentWifiSSID
{
    NSArray *ifs = (__bridge  id)CNCopySupportedInterfaces();
//    NSArray *itf = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    NSDictionary *SSIDInfo;
    for (NSString *ifname in ifs) {
        SSIDInfo = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
        BOOL isNotEmpty = (SSIDInfo.count > 0);
        if (isNotEmpty) {
            break;
        }
    }
    return SSIDInfo;
}

- (void)addButtonClick:(UIButton *)button
{
    if ([button.currentTitle isEqualToString:@"连接其他Wi-Fi"]) {
        [self jumpToSettings];
        
    } else {
        if ([YFCommonCode isBlankString:self.wifiField.text]) {
//            [SVProgressHUD showErrorWithText:@"请输入WiFi"];
            return;
        }
        
        if ([YFCommonCode isBlankString:self.pwdField.text]) {
//            [SVProgressHUD showErrorWithText:@"请输入WiFi密码"];
            return;
        }
        if (!self.bssid) {
//            [SVProgressHUD showErrorWithText:@"未连接到WiFi"];
            return;
        }
        [SVProgressHUD loadingWithText:@""];
        [[YFBleManager shareTool] connectToInternetWithWifiName:self.wifiField.text wifiPassword:self.pwdField.text];
        
        
//        self.bluetooth.delegate = nil;
//        
//        YFConnectDeviceController *conn = [[YFConnectDeviceController alloc] init];
//        
//        conn.ssidStr = self.ssidStr;
//        conn.password = self.pwdField.text;
//        conn.connectBssid = self.bssid;
//        conn.serialNumber = self.serialNumber;
//        [self.navigationController pushViewController:conn animated:YES];
        
    }

}

- (void)didSuccessToConnectToInternet:(CBPeripheral *)peripheral
{
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"设备配网成功");
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithText:@"设备配网成功"];
        [[YFBleManager shareTool] cancelPeripheralConnection];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    });
    
}

- (void)didFailToConnectToInternet:(NSString *)error
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithText:@"设备配网失败"];
}


- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithText:@"设备已经断开连接"];
        [[YFBleManager shareTool] cancelPeripheralConnection];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
    });
    
}

#pragma mark - 明密文切换
- (void)eyeBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    self.pwdField.secureTextEntry = !button.selected;
    
    NSString *pwd1 = self.pwdField.text;
    self.pwdField.text = @"";
    self.pwdField.text = pwd1;
}

- (void)jumpToSettings
{
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.wifiField) {
        return NO;
    }
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
//    kCLAuthorizationStatusDenied
    [self enterForeground];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (YFTextField *)wifiField{
    if (!_wifiField) {
        _wifiField = [[YFTextField alloc] initWithFrame:CGRectMake(30, 100, kScreenW - 60, 40)];
        _wifiField.borderStyle = UITextBorderStyleNone;
        _wifiField.font = [UIFont systemFontOfSize:16];
        _wifiField.delegate = self;
        _wifiField.backgroundColor = kRGBCOLOR(235, 235, 235);
        _wifiField.layer.cornerRadius = _wifiField.height/2;
        
        _wifiField.leftViewMode = UITextFieldViewModeAlways;
        _wifiField.rightViewMode = UITextFieldViewModeAlways;
        
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"WiFi";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat width = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width + 30;
        _wifiField.leftViewBounds = CGRectMake(0, 0, width, _wifiField.height);
        _wifiField.leftView = label;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"icon_transformation"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_transformation"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(jumpToSettings) forControlEvents:UIControlEventTouchUpInside];
        width = _wifiField.height + 10;
        _wifiField.rightViewBounds = CGRectMake(_wifiField.width - width, 0, width, _wifiField.height);
        _wifiField.rightView = button;
        
    }
    return _wifiField;
}

- (YFTextField *)pwdField
{
    if (!_pwdField) {
        _pwdField = [[YFTextField alloc] initWithFrame:CGRectMake(30, self.wifiField.bottom + 15, kScreenW - 60, 40)];
        _pwdField.borderStyle = UITextBorderStyleNone;
        _pwdField.font = [UIFont systemFontOfSize:16];
        _pwdField.delegate = self;
        _pwdField.backgroundColor = kRGBCOLOR(235, 235, 235);
        _pwdField.layer.cornerRadius = _pwdField.height/2;
//        _pwdField.placeholder = @"当前设备不支持5Ghz网络";
        _pwdField.secureTextEntry = YES;
        
        _pwdField.leftViewMode = UITextFieldViewModeAlways;
        _pwdField.rightViewMode = UITextFieldViewModeAlways;
        
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"密码";
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        CGFloat width = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width + 30;
        _pwdField.leftViewBounds = CGRectMake(0, 0, width, _pwdField.height);
        _pwdField.leftView = label;
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"login_icon_display_yes"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"login_icon_display_no"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        width = _pwdField.height + 10;
        _pwdField.rightViewBounds = CGRectMake(_pwdField.width - width, 0, width, _pwdField.height);
        _pwdField.rightView = button;
    
    }
    return _pwdField;
}


- (UIButton *)addButton
{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _addButton.frame = CGRectMake(60, kScreenH - 150, kScreenW - 120, 45);
        [_addButton setBackgroundColor:kRGBCOLOR(0, 167, 175)];
        [_addButton setTitle:@"点击添加" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _addButton.layer.cornerRadius = 5;
        [_addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
