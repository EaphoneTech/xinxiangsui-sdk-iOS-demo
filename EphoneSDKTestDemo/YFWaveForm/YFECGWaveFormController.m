//
//  YFECGWaveFormController.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/12/28.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "YFECGWaveFormController.h"
#import "ECGView.h"
#import "YFWaveFormView.h"

#import "YFLeaveSeatAlertView.h"
#import "YFECGCoverView.h"
#import "YFReconnectBleAlertView.h"
#import "AppDelegate.h"
//#import "YFECGBLEConnectFailController.h"


@interface YFECGWaveFormController ()<YFBluetoothDelegate>

@property (nonatomic, strong) YFWaveFormView *waveFormView; //心电图

@property (nonatomic, strong) ECGView *ecgView; //心电图
@property (nonatomic, strong) ECGView *PPGIRView;  //PPG红外数据
@property (nonatomic, strong) YFECGCoverView *coverView;
@property (nonatomic, strong) YFECGCoverView *PPGIRCoverView;  //PPG红外cover
@property (nonatomic, strong) UIImageView *heartImgView;
@property (nonatomic, strong) UILabel *heartRateLab;
@property (nonatomic, strong) UILabel *durationLab;  //测量时长
@property (nonatomic, strong) UIButton *checkBtn;  //查看设备最新的健康数据分析结果
@property (nonatomic, strong) UITextView *textView;  


@property (nonatomic, strong) YFReconnectBleAlertView *reconnectBleAlert;
@property (nonatomic, strong) YFLeaveSeatAlertView *leaveSeatAlert;


@property (nonatomic, strong) NSTimer *timer;;
@property (nonatomic, assign) int t;  //弹框重连时间

@property (nonatomic, strong) UIScrollView *scrollView;  //页面内容过长，滚动显示

//@property (nonatomic, strong) YFBluetooth *bluetooth;

@end

@implementation YFECGWaveFormController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"实时波形";
    
    [self setupUI];
    
    [YFBleManager shareTool].bluetooth = [[YFBluetooth alloc] init];
    [YFBleManager shareTool].bluetooth.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (void)setupUI {
    
    self.waveFormView.ppgView.hidden = [YFBleManager shareTool].isHasPPG ? NO : YES;
    
    self.ecgView.height = [YFBleManager shareTool].isHasPPG ? 150 : 235;
    self.ecgView.pointMartin = [YFBleManager shareTool].isHasPPG ? 3 : 1;
    [self.ecgView drawGrid];
    self.ecgView.drawerColor = kRGBCOLOR(227, 53, 22);
    self.coverView.frame = self.ecgView.bounds;
    self.PPGIRView.hidden = [YFBleManager shareTool].isHasPPG ? NO : YES;
    self.PPGIRView.pointMartin = [YFBleManager shareTool].isHasPPG ? 3 : 1;
    self.heartRateLab.top = [YFBleManager shareTool].isHasPPG ? self.PPGIRView.bottom : self.ecgView.bottom ;
    self.heartRateLab.height = self.waveFormView.height - self.heartRateLab.top;
    _heartImgView.centerY = self.heartRateLab.centerY;
    _durationLab.centerY = self.heartRateLab.centerY;
    
    [self.waveFormView addSubview:self.ecgView];
    [self.waveFormView addSubview:self.PPGIRView];
    [self.waveFormView addSubview:self.heartRateLab];
//    [self.waveFormView addSubview:self.heartImgView];
    [self.waveFormView addSubview:self.durationLab];
    [self.view addSubview:self.checkBtn];

}

#pragma mark - YFBluetoothDelegate

- (void)bluetoothECGWaveData:(NSMutableArray *)array
{
    self.ecgView.ecgArray = array.mutableCopy;
}


- (void)bluetoothAllWaveECG:(NSMutableArray *)ECGArray PPGRedLight:(NSMutableArray *)PPGRedLightArray PPGInfrared:(NSMutableArray *)PPGInfraredArray
{
    self.ecgView.ecgArray = ECGArray.mutableCopy;
    self.PPGIRView.ecgArray = PPGInfraredArray.mutableCopy;
}


- (void)bluetoothHeartRate:(long)heartRate
{
    self.heartRateLab.text = [NSString stringWithFormat:@"心率：%ld bpm", heartRate];
}

- (void)monitoringDurationOfTheDevice:(long)monitoringTime
{
    self.durationLab.text = [NSString stringWithFormat:@"监测时长：%ld S",monitoringTime];
}

- (void)deviceStatusOfLeaveSeat:(BOOL)isLeaveSeat
{
    WEAKSELF;
//    if (isLeaveSeat) {
//        self.leaveSeatAlert = [[YFLeaveSeatAlertView alloc] init];
//        [self.leaveSeatAlert showView];
//
//        self.leaveSeatAlert.exitClickBlock = ^{
//            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//        };
//    } else {
//        if (self.leaveSeatAlert.isShow) {
//            [self.leaveSeatAlert continueButtonClick];
//        }
//    }
    
    if (isLeaveSeat) {
        self.checkBtn.hidden = NO;
    } else {
        self.checkBtn.hidden = YES;
        self.textView.text = @"";
    }
}


- (void)ECGSignalStatus:(BOOL)signalStatus
{
    if (signalStatus) {
        self.coverView.hidden = YES;
    } else {
        self.coverView.hidden = NO;
    }
}

- (void)PPGSignalStatus:(BOOL)signalStatus
{
    if (signalStatus) {
        self.PPGIRCoverView.hidden = YES;
    } else {
        self.PPGIRCoverView.hidden = NO;
    }
}

- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.t = 0;
        
        weakSelf.reconnectBleAlert = [[YFReconnectBleAlertView alloc] init];
        weakSelf.reconnectBleAlert.exitClickBlock = ^{
            
            if ([weakSelf.timer isValid]) {
                [weakSelf.timer invalidate];
            }
            weakSelf.timer = nil;
        
            [weakSelf.reconnectBleAlert removeView];
            [weakSelf backAction];
            
        };
        [weakSelf.reconnectBleAlert showView];
        
        [[YFBleManager shareTool] connectPeripheral:peripheral];
        
        weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reconnectTimer) userInfo:nil repeats:YES];
    });
}


- (void)reconnectTimer
{
//    if ([self.timer isValid]) {
//        if (self.t >= 15) {
//            if (self.reconnectBleAlert.isShow) {
//                [self.reconnectBleAlert removeView];
//                YFECGBLEConnectFailController *fail = [[YFECGBLEConnectFailController alloc] init];
//                fail.model = self.model;
//                [self.navigationController pushViewController:fail animated:YES];
//
//                [self.timer invalidate];
//                self.timer = nil;
//
//                if (self.leaveSeatAlert.isShow) {
//                    [self.leaveSeatAlert removeView];
//                }
//            }
//        }
//        self.t ++;
//    }
    
    
}



- (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral {
    
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"YFECGWaveFormController设备连接成功代理：%@",peripheral);
        [weakSelf.reconnectBleAlert removeView];
        
        if ([weakSelf.timer isValid]) {
            [weakSelf.timer invalidate];
        }
        weakSelf.timer = nil;
    });
}

- (void)checkDataAction {
    [self getLastData:[NSNumber numberWithInt:1]];
}

- (void) getLastData:(NSNumber *)time {
    [SVProgressHUD loadingWithText:@""];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSArray *arr = [self.peripheral.name componentsSeparatedByString:@"."];
    NSString *serialNumber = arr[1];
    
    WEAKSELF;
    [YFDeviceAPIHelpers YFLastOfDeviceDataWithAccessToken:appDelegate.access_token deviceid:serialNumber success:^(id responseObject) {
        [SVProgressHUD dismiss];
//        [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(getLastData:) object:nil];

        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *jsonString;

        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

        self.textView.text = jsonString;
        
    } failure:^(NSError *error, NSString *errorDes) {
        if (error.code == YFErrCodeHealthDataUploading || error.code == YFErrCodeHealthDataUnderAnalysis) {  //数据上传中/数据分析中
            if ([time intValue] < 10) {
                [weakSelf performSelector:@selector(getLastData:) withObject:[NSNumber numberWithInt:([time intValue] + 1)] afterDelay:3.0];
            } else {
                [SVProgressHUD dismiss];
//                [NSObject cancelPreviousPerformRequestsWithTarget:weakSelf selector:@selector(getLastData:) object:nil];
                weakSelf.textView.text = @"此次测量尚未分析出数据报告";
            }
            
        } else {
            [SVProgressHUD dismiss];
            switch (error.code) {
                case YFErrCodeHealthDataNotExit:
                    weakSelf.textView.text = @"数据不存在";
                    break;
                case YFErrCodeHealthDataTimeShort:
                    weakSelf.textView.text = @"数据时长不够";
                    break;
                    
                default:
                    weakSelf.textView.text = [NSString stringWithFormat:@"%ld,%@", (long)error.code, errorDes];
                    break;
            }
            
        }
        
    }];
}


- (UIButton *)checkBtn
{
    if (!_checkBtn) {
        _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkBtn.frame = CGRectMake(60, self.waveFormView.bottom + 80, kScreenW - 120, 50);
    
        [_checkBtn setTitle:@"查看最新的数据分析结果" forState:UIControlStateNormal];
        _checkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_checkBtn setBackgroundColor:[UIColor blueColor]];
        
        [_checkBtn addTarget:self action:@selector(checkDataAction) forControlEvents:UIControlEventTouchUpInside];
        _checkBtn.hidden = YES;
    }
    return _checkBtn;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.checkBtn.bottom, self.view.width, 100)];
        [self.view addSubview:_textView];
    }
    return _textView;
}


- (void)backAction
{
    
    [[YFBleManager shareTool] cancelPeripheralConnection];
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        
        _scrollView.backgroundColor = [UIColor clearColor];
        
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (YFWaveFormView *)waveFormView
{
    if (!_waveFormView) {
        _waveFormView = [[YFWaveFormView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 410)];
        [self.scrollView addSubview:_waveFormView];
    }
    return _waveFormView;
}

- (ECGView *)ecgView
{
    if (!_ecgView) {
        _ecgView = [[ECGView alloc] initWithFrame:CGRectMake(18, 50, [UIScreen mainScreen].bounds.size.width - 36, 150)];
        [_ecgView addSubview:self.coverView];
    }
    return _ecgView;
}

- (ECGView *)PPGIRView
{
    if (!_PPGIRView) {
        _PPGIRView = [[ECGView alloc] initWithFrame:CGRectMake(18, self.ecgView.bottom + 9, [UIScreen mainScreen].bounds.size.width - 36, 150)];
        [_PPGIRView addSubview:self.PPGIRCoverView];
        [_PPGIRView drawGrid];
        _PPGIRView.drawerColor = kRGBCOLOR(30, 175, 28);
        
        
    }
    return _PPGIRView;
}

- (YFECGCoverView *)PPGIRCoverView
{
    if (!_PPGIRCoverView) {
        _PPGIRCoverView = [[YFECGCoverView alloc] initWithFrame:self.PPGIRView.bounds];
        _PPGIRCoverView.tipString = @"未检测到有效PPG信号，请挪动臀部调整坐姿或检查皮肤与电极片之间是否有衣物遮挡。";
        _PPGIRCoverView.hidden = YES;
    }
    return _PPGIRCoverView;
}

- (YFECGCoverView *)coverView
{
    if (!_coverView) {
        _coverView = [[YFECGCoverView alloc] initWithFrame:self.ecgView.bounds];
        _coverView.tipString = @"未检测到有效ECG信号，请挪动臀部调整坐姿或检查皮肤与电极片之间是否有衣物遮挡。";
        _coverView.hidden = YES;
    }
    return _coverView;
}

- (UILabel *)heartRateLab
{
    if (!_heartRateLab) {
        _heartRateLab = [[UILabel alloc] initWithFrame:CGRectMake(18, self.PPGIRView.bottom + 20, 150, 25)];
        _heartRateLab.text = @"心率：";
        _heartRateLab.textColor = kRGBCOLOR(102, 102, 102);
        _heartRateLab.font = [UIFont systemFontOfSize:15];
        
        _heartRateLab.textAlignment = NSTextAlignmentLeft;
//        _heartRateLab.hidden = YES;

    }
    return _heartRateLab;
}

- (UIImageView *)heartImgView
{
    if (!_heartImgView) {
        _heartImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, self.PPGIRView.bottom + 20, 25, 25)];
        _heartImgView.image = [UIImage imageNamed:@"icon_ecg-3"];
        _heartImgView.contentMode = UIViewContentModeScaleAspectFit;
        _heartImgView.centerY = self.heartRateLab.centerY;
//        self.heartRateLab.left = _heartImgView.right + kAdapterWidth(20);
        _heartImgView.hidden = YES;
    }
    return _heartImgView;
}


- (UILabel *)durationLab
{
    if (!_durationLab) {
        _durationLab = [[UILabel alloc] initWithFrame:CGRectMake(self.heartRateLab.right, self.ecgView.bottom + 20, [UIScreen mainScreen].bounds.size.width - 25 - self.heartRateLab.right, 25)];
        _durationLab.textColor = kRGBCOLOR(102, 102, 102);
        _durationLab.font = [UIFont systemFontOfSize:15];
        _durationLab.text = @"监测时长：";
        _durationLab.textAlignment = NSTextAlignmentRight;
        _durationLab.centerY = self.heartRateLab.centerY;
    }
    return _durationLab;
}


- (void)dealloc
{
    if (self.leaveSeatAlert.isShow) {
        [self.leaveSeatAlert removeView];
    }
    [[YFBleManager shareTool] cancelPeripheralConnection];
}

@end
