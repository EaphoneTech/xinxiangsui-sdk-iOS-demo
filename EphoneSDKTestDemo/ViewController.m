//
//  ViewController.m
//  EphoneSDKTestDemo
//
//  Created by 王丽珍 on 2020/12/9.
//

#import "ViewController.h"
#import <EphoneSDK/EphoneSDK.h>

#import <arpa/inet.h>
#import <ifaddrs.h>
#import "YFECGWaveFormController.h"
#import "YFBluetoothScanViewController.h"


@interface ViewController ()<YFBluetoothDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UITextField *serialNumField;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) YFBluetooth *bluetooth;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    [[YFBleManager shareTool] initManager];
}


- (void)setupUI {
    
//    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.height - 300, self.view.width, 300)];
//    [self.view addSubview:self.textView];
    
    self.serialNumField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
    self.serialNumField.centerX = self.view.centerX;
    self.serialNumField.borderStyle = UITextBorderStyleRoundedRect;
    self.serialNumField.layer.borderWidth = 1.5;
    self.serialNumField.layer.cornerRadius = 1;
    self.serialNumField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.serialNumField];
    self.serialNumField.placeholder = @"请输入设备序列号";
    
    self.serialNumField.text = @"919210100000152";
    
    //bind/app
    UIButton *connWifi = [UIButton buttonWithType:UIButtonTypeCustom];
    connWifi.frame = CGRectMake(20, self.serialNumField.bottom + 100, 200, 40);
    connWifi.centerX = self.view.centerX;
    [self.view addSubview:connWifi];
    [connWifi setTitle:@"设备配网" forState:UIControlStateNormal];
    [connWifi setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [connWifi setBackgroundColor:kRGBCOLOR(0, 167, 175)];
    [connWifi addTarget:self action:@selector(connWifi:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *waveForm = [UIButton buttonWithType:UIButtonTypeCustom];
    waveForm.frame = CGRectMake(20, connWifi.bottom + 50, 200, 40);
    waveForm.centerX = self.view.centerX;
    [self.view addSubview:waveForm];
    [waveForm setTitle:@"实时波形" forState:UIControlStateNormal];
    [waveForm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [waveForm setBackgroundColor:kRGBCOLOR(0, 167, 175)];
    [waveForm addTarget:self action:@selector(waveFormAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)connWifi:(id)sender {
    
    if ([YFBleManager shareTool].peripheralState != CBManagerStatePoweredOn) {

        [self BAAlertWithTitle:@"请先将手机蓝牙与设备连接\n打开蓝牙" message:@"" andOthers:@[@"确定"] animated:YES action:^(NSInteger index) {

        }];
        return;
    } else {

        YFBluetoothScanViewController *conn = [[YFBluetoothScanViewController alloc] init];
        [self.navigationController pushViewController:conn animated:YES];
        
    }
}


- (void)waveFormAction:(id)sender {
    
    if ([YFBleManager shareTool].peripheralState != CBManagerStatePoweredOn) {

        [self BAAlertWithTitle:@"请先将手机蓝牙与设备连接\n打开蓝牙" message:@"" andOthers:@[@"确定"] animated:YES action:^(NSInteger index) {

        }];
        return;
    } else {

        self.bluetooth = [[YFBluetooth alloc] init];
        self.bluetooth.delegate = self;
        
        [[YFBleManager shareTool] scanPeripheral];
        
    }
}


- (void)didDiscoverPeripheral:(CBPeripheral *)peripheral
{
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"peripheral === %@",peripheral);

        if (![peripheral.name isEqualToString:@"xinxiangsui"]) {
            NSArray *arr = [peripheral.name componentsSeparatedByString:@"."];
            if ([weakSelf.serialNumField.text isEqualToString:arr[1]]) {
                [[YFBleManager shareTool] connectPeripheral:peripheral];
                return;
            }
        }
    });
}



- (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral {
    
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"ViewController设备连接成功代理：%@",peripheral);
        weakSelf.bluetooth.delegate = nil;
        weakSelf.bluetooth = nil;
        YFECGWaveFormController *ecgWave = [[YFECGWaveFormController alloc] init];
        ecgWave.peripheral = peripheral;
        [weakSelf.navigationController pushViewController:ecgWave animated:YES];
    });
}


- (void)printLogData:(id)responseObject
{
//    NSDictionary *dic = [responseObject mj_keyValues];
    NSDictionary *dic = (NSDictionary *)responseObject;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString;

    jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    self.textView.text = jsonString;
}


@end
