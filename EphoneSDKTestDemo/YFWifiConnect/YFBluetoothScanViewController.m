//
//  YFBluetoothScanViewController.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/10/26.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "YFBluetoothScanViewController.h"
#import "YFConfigureWiFiViewController.h"

@interface YFBluetoothScanViewController ()<UITableViewDelegate,UITableViewDataSource,YFBluetoothDelegate>

@property (nonatomic, strong) UITableView *deviceTableView;

@property (nonatomic, strong) NSMutableArray *deviceArr;

@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) YFBluetooth *bluetooth;

@end

@implementation YFBluetoothScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"扫描附近设备";
    
    self.bluetooth = [[YFBluetooth alloc] init];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.bluetooth.delegate = self;
    [self.deviceArr removeAllObjects];

    [[YFBleManager shareTool] scanPeripheral];
    
}


- (void)didScanDevicesPeripheral:(CBPeripheral *)peripheral
{
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakSelf.deviceArr addObject:peripheral];
        [weakSelf.deviceTableView reloadData];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceArr.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"YFBluetoothScanDeviceListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        CBPeripheral *peripheral = self.deviceArr[indexPath.row];
        
        cell.textLabel.text = peripheral.name;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CBPeripheral *peripheral = self.deviceArr[indexPath.row];

    self.peripheral = peripheral;
    
    [[YFBleManager shareTool] connectPeripheral:peripheral];
    
}


- (void)didConnectSuccessPeripheral:(CBPeripheral *)peripheral
{
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        weakSelf.bluetooth.delegate = nil;
        
        YFConfigureWiFiViewController *wifi = [[YFConfigureWiFiViewController alloc] init];
        wifi.peripheral = weakSelf.peripheral;
        [weakSelf.navigationController pushViewController:wifi animated:YES];
   
    });
}

- (UITableView *)deviceTableView
{
    if (!_deviceTableView) {
        _deviceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) style:UITableViewStylePlain];
        _deviceTableView.backgroundColor = [UIColor whiteColor];
        _deviceTableView.tableFooterView = [UIView new];
        
        _deviceTableView.dataSource = self;
        _deviceTableView.delegate = self;
        
        [self.view addSubview:_deviceTableView];
    }
    return _deviceTableView;
}

- (NSMutableArray *)deviceArr
{
    if (!_deviceArr) {
        _deviceArr = [NSMutableArray array];
    }
    return _deviceArr;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

@end
