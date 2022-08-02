//
//  YFConnectDeviceController.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/12.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "YFConnectDeviceController.h"
#import "YFConnectView.h"
#import "YFConnectDeviceFailController.h"
#import "YFConnectDeviceSuccessController.h"

#import <arpa/inet.h>
#import <ifaddrs.h>

@interface YFConnectDeviceController ()<YFBluetoothDelegate>

//@property (nonatomic, strong) YFBluetooth *bluetooth;

@property (nonatomic, strong) YFConnectView *connectView;

///进度条的计时器
@property(nonatomic,strong)NSTimer * timer;

///轮询接口 计时器
@property(nonatomic,strong)NSTimer * timer2;

///手机ip地址
@property(nonatomic,copy)NSString *phoneAddress;

///设备地址
@property(nonatomic,copy)NSString * deviceAddress;  //esptouch 获取

@property(nonatomic,assign)CGFloat i;   //配网计时


@property (nonatomic, assign) BOOL isWifiPwdError;  //Wi-Fi密码错误
@property (nonatomic, strong) NSString *bindErrorString;  //绑定设备失败原因

@end

@implementation YFConnectDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"添加设备";
    
    
    [self connectView];
    
    if (self.connectBssid.length == 16) {
        self.connectBssid = [NSString stringWithFormat:@"0%@",self.connectBssid];
    }
    ///变为大写
    //   self.connectBssid = [self.connectBssid uppercaseString];
    NSLog(@"%@",self.connectBssid);
    self.phoneAddress  = [self getIpAddresses];
    
    [self bindingDevice];
    
    self.i = 0.0f;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timecalculate) userInfo:nil repeats:YES];
    [_timer fire];
    
    
//    self.bluetooth = [[YFBluetooth alloc] init];
    [YFBleManager shareTool].bluetooth.delegate = self;

}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.timer2 setFireDate:[NSDate distantFuture]];
}

- (void)didFailToConnectToInternet:(NSString *)error
{
    NSArray *arr = [error componentsSeparatedByString:@":"];
    if (arr.count > 1) {
        if ([arr[1] isEqualToString:@"410"]) {  //密码错误
            self.isWifiPwdError = YES;
        }
    }
    self.bindErrorString = error;
}


///发起设备绑定
- (void)bindingDevice{
    /*
    WEAKSELF;
    
    
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
//    [param setValue:@"096efa48-385b-11ec-9e42-8dcd1021ec73" forKey:@"token"];
    [param setValue:self.ssidStr forKey:@"ssid"];
    [param setValue:self.connectBssid forKey:@"bssid"];
    [param setValue:self.phoneAddress forKey:@"phoneAddress"];
    [param setValue:self.serialNumber forKey:@"serialNumber"];
    [param setValue:@"ble" forKey:@"type"];
//    [param setValue:self.familyModel.ID forKey:@"familyId"];
//    [param setValue:self.model.bind_instruction.bind_type forKey:@"type"];
    
    [[YFNetworkTool shareTool] POST:@"g08/v1/bind/app/" parameters:param success:^(YFNetworkDataModel *responseModel) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.connectView.connectStep = YFConnectStepOne;
        });
        
    } failure:^(NSError *error, NSString *errorDes) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
//            [SVProgressHUD showErrorWithText:errorDes];
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            
            [weakSelf.timer2 invalidate];
            weakSelf.timer2 = nil;
            
            [weakSelf.timer setFireDate:[NSDate distantFuture]];
            [weakSelf.timer2 setFireDate:[NSDate distantFuture]];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
        
    }];
    */
    
}



- (void)bindStatus
{
    /*
    WEAKSELF;
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.serialNumber, @"serialNumber", nil];
    [[YFNetworkTool shareTool] GET:@"g08/v1/bind/status/" parameters:param success:^(YFNetworkDataModel *responseModel) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([responseModel.data isEqualToString:@"success"]) {
                if (weakSelf.i <= 60) {
                    [weakSelf.timer setFireDate:[NSDate distantFuture]];
                    [weakSelf.timer2 setFireDate:[NSDate distantFuture]];
                    
                    [weakSelf.timer invalidate];
                    weakSelf.timer = nil;
                    
                    [weakSelf.timer2 invalidate];
                    weakSelf.timer2 = nil;
                    
                    CGFloat t;
                    if ((1 - (weakSelf.i*(0.9/60.0))) >= 0.5) {
                        t = 3.5;
                    } else {
                        t = (1 - (weakSelf.i*(0.9/60.0))) / 0.10 * 0.7;
                    }
                    
                    [weakSelf.connectView.progressView setProgress:weakSelf.i*(0.9/60.0) animated:YES];
                    [UIView animateWithDuration:t animations:^{
                        [weakSelf.connectView.progressView setProgress:1.0 animated:YES];
                        weakSelf.connectView.connectStep = YFConnectStepThree;
                    } completion:^(BOOL finished) {
                        
                    }];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(t * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        YFConnectDeviceSuccessController *vc =[[YFConnectDeviceSuccessController alloc] init];
                        vc.wifiName = weakSelf.ssidStr;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    });
                }else if (weakSelf.i > 60){
                    [weakSelf.timer setFireDate:[NSDate distantFuture]];
                    [weakSelf.timer2 setFireDate:[NSDate distantFuture]];
                    
                    [weakSelf.timer invalidate];
                    weakSelf.timer = nil;
                    
                    [weakSelf.timer2 invalidate];
                    weakSelf.timer2 = nil;
                    
                    [weakSelf.connectView.progressView setProgress:((self.i - 60.0)*(0.1/30.0) + 0.9) animated:YES];
                    [UIView animateWithDuration:1.5 animations:^{
                        [weakSelf.connectView.progressView setProgress:1.0 animated:YES];
                        weakSelf.connectView.connectStep = YFConnectStepThree;
                    } completion:^(BOOL finished) {
                    }];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        YFConnectDeviceSuccessController *vc =[[YFConnectDeviceSuccessController alloc] init];
                        vc.wifiName = weakSelf.ssidStr;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    });
                }
            }
        });
        
    } failure:^(NSError *error, NSString *errorDes) {
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
            
            [weakSelf.timer2 invalidate];
            weakSelf.timer2 = nil;
            
            if ([errorDes isEqualToString:@"already_bond_by_other"]) {
                [weakSelf BAAlertWithTitle:@"该设备已被绑定，如需解绑请联系客服。客服电话：400-621-134" message:nil andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
                }];
            }else {
                YFConnectDeviceFailController* vc =[[YFConnectDeviceFailController alloc] init];
                vc.isWifiPwdError = weakSelf.isWifiPwdError;
                vc.bindErrorString = weakSelf.bindErrorString;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
        });
    }];
    */
}


- (NSString *)getIpAddresses{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (void)timecalculate
{
    self.i += 0.1;
//    NSLog(@"%.1f",self.i);
    
    if (self.i <= 60.0) {
        [self.connectView.progressView setProgress:self.i*(0.9/60.0) animated:YES];
        
        if (self.i >= 20.0) {
            if (self.timer2) return;
            self.connectView.connectStep = YFConnectStepTwo;
            if (@available(iOS 10.0, *)) {
                self.timer2 = [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    [self bindStatus];
                }];
                [self.timer2 fire];
            } else {
                // Fallback on earlier versions
            }
        }
        
    } else if (self.i > 60.0 && self.i < 90.0) {
        
        [self.connectView.progressView setProgress:((self.i - 60.0)*(0.1/30.0) + 0.9) animated:YES];
        
    } else if (self.i >= 90.0) {
        [self.timer invalidate];
        self.timer = nil;
        [self.timer2 invalidate];
        self.timer2 = nil;
        
        YFConnectDeviceFailController* vc =[[YFConnectDeviceFailController alloc] init];
        vc.isWifiPwdError = self.isWifiPwdError;
        vc.bindErrorString = self.bindErrorString;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}


- (void)leftBackAction
{
    WEAKSELF;
    [self BAAlertWithTitle:@"离开本页面会终止设备连接，确认离开" message:nil andOthers:@[@"否",@"是"] animated:YES action:^(NSInteger index) {
        if (index == 1) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.timer setFireDate:[NSDate distantFuture]];
                [weakSelf.timer2 setFireDate:[NSDate distantFuture]];
                
                [weakSelf.timer invalidate];
                weakSelf.timer = nil;
                [weakSelf.timer2 invalidate];
                weakSelf.timer2 = nil;
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
            
        }
    }];
}

- (YFConnectView *)connectView{
    if (!_connectView) {
        _connectView = [[YFConnectView alloc] initWithFrame:self.view.bounds];
        
        _connectView.wifiLabel.text = self.ssidStr;
        _connectView.imageView.image = [UIImage imageNamed:@"device_matong"];
        _connectView.connectTitle.text = [NSString stringWithFormat:@"正在配置网络,请耐心等待..."];
        [self.view addSubview:_connectView];
        
    }
    return _connectView;
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    [self.timer2 invalidate];
    self.timer2 = nil;
}

@end
