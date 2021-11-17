//
//  YFConnectDeviceSuccessController.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/12.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "YFConnectDeviceSuccessController.h"

@interface YFConnectDeviceSuccessController ()
{
    int count;
    NSTimer *timer;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *doneButton;

@property (nonatomic, strong) UILabel *contentLab;

@property (nonatomic, strong) UILabel *resetSuccessLabel;

@end

@implementation YFConnectDeviceSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定成功";

    
    [self.view addSubview:self.label];
    [self.view addSubview:self.contentLab];
    [self.view addSubview:self.doneButton];
    [self.view addSubview:self.resetSuccessLabel];
//    
//    self.contentLab.hidden = self.isResetWiFi ? YES : NO;
//    self.resetSuccessLabel.hidden = self.isResetWiFi ? NO : YES;
//    
//    if (self.isResetWiFi) {
//        self.resetSuccessLabel.text = [NSString stringWithFormat:@"Wi-Fi网络已重置为\n%@",self.wifiName];
//        _resetSuccessLabel.numberOfLines = 0;
//        [_resetSuccessLabel sizeToFit];
//        _resetSuccessLabel.textAlignment = NSTextAlignmentCenter;
//        _resetSuccessLabel.centerX = self.view.centerX;
//        
//        self.doneButton.enabled = YES;
//        [self.doneButton setBackgroundColor:kRGBCOLOR(0, 167, 175)];
//    } else {
//        [self performSelector:@selector(doneCount:) withObject:[NSNumber numberWithInt:3]];
//    }

    [[YFBleManager shareTool] cancelPeripheralConnection];
    
}



//倒计时
- (void)doneCount:(NSNumber *)countNum
{
    self.doneButton.enabled = NO;
    count = [countNum intValue];
    [self.doneButton setTitle:[NSString stringWithFormat:@"完成（%d）",count] forState:UIControlStateDisabled];
    
    if (timer != nil) {
        [timer invalidate];
        timer = nil;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
}

-(void)timer
{
    if (count !=1) {
        count -=1;
        [self.doneButton setTitle:[NSString stringWithFormat:@"完成（%d）",count] forState:UIControlStateDisabled];
    }
    else
    {
        [timer invalidate];
        self.doneButton.enabled = YES;
        [self.doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [self.doneButton setBackgroundColor:kRGBCOLOR(0, 167, 175)];
    }
}


- (void)doneButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.frame = CGRectMake(60, kScreenH - 150, kScreenW - 120, 45);
//        [_doneButton setBackgroundColor:kColorTheme];
        [_doneButton setBackgroundColor:kRGBCOLOR(160, 160, 160)];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _doneButton.layer.cornerRadius = 6;
        [_doneButton addTarget:self action:@selector(doneButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _doneButton.enabled = NO;
        
        [self.view addSubview:_doneButton];
    }
    return _doneButton;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_binding_success"]];
        _imageView.frame = CGRectMake(0, 110, 120, 120);
//        _imageView.top = kAdapterHeight(280);
        _imageView.centerX = self.view.centerX;
        _imageView.layer.contentsGravity =kCAGravityResizeAspectFill;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(30, self.imageView.bottom + 15, kScreenW - 60, 60)];
        _label.textColor = kRGBCOLOR(178, 178, 178);
        _label.font = [UIFont systemFontOfSize:16];
//        _label.text = @"绑定成功";
        _label.text = @"建议您前往微信公众号“心相随”\n进行日常操作使用";
        _label.numberOfLines = 0;
        [_label sizeToFit];
        
        _label.textAlignment = NSTextAlignmentCenter;
        _label.centerX = self.view.width/2;
        
        _label.hidden = YES;
        
    }
    return _label;
}

- (UILabel *)contentLab
{
    if (!_contentLab) {
        
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(50, self.label.bottom + 15, kScreenW - 100, 10)];
        
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"初次使用您可能对以下内容感兴趣"];
        [attributedString addAttributes:@{NSForegroundColorAttributeName:kRGBCOLOR(178, 178, 178)} range:[[attributedString string] rangeOfString:attributedString.string]];
        
        NSMutableArray *tapArr = [NSMutableArray array];
        
        [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:NSMakeRange(0, attributedString.length)];
        
        _contentLab.attributedText = attributedString;
        
        _contentLab.numberOfLines = 0;
        [_contentLab sizeToFit];
        _contentLab.lineBreakMode = NSLineBreakByWordWrapping;
        
    }
    return _contentLab;
}


- (UILabel *)resetSuccessLabel
{
    if (!_resetSuccessLabel) {
        _resetSuccessLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.imageView.bottom + 60, kScreenW - 40, 30)];
        _resetSuccessLabel.textColor = [UIColor blackColor];
        _resetSuccessLabel.font = [UIFont systemFontOfSize:16];

        _resetSuccessLabel.hidden = YES;
        [self.view addSubview:_resetSuccessLabel];
    }
    return _resetSuccessLabel;
}

@end
