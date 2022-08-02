//
//  YFConnectDeviceFailController.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/12.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "YFConnectDeviceFailController.h"
#import "YFConfigureWiFiViewController.h"

@interface YFConnectDeviceFailController ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *retryButton;

@property (nonatomic, strong) UILabel *label;

@end

@implementation YFConnectDeviceFailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定失败";
    
    [self.view addSubview:self.retryButton];
    [self.view addSubview:self.label];
    
    [[YFBleManager shareTool] cancelPeripheralConnection];
}


- (void)retryButtonClick
{
//    YFConfigureWiFiViewController *vc = [[YFConfigureWiFiViewController alloc] init];
//    [self.navigationController popToTargetViewController:vc animated:YES];
}


- (UIButton *)retryButton
{
    if (!_retryButton) {
        _retryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _retryButton.frame = CGRectMake(60, kScreenH - 150, kScreenW - 120, 45);
        [_retryButton setBackgroundColor:kRGBCOLOR(0, 167, 175)];
        [_retryButton setTitle:@"重试" forState:UIControlStateNormal];
        [_retryButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _retryButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _retryButton.layer.cornerRadius = 5;
        [_retryButton addTarget:self action:@selector(retryButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(20, self.imageView.bottom + 60, kScreenW - 40, 30)];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:16];
        NSString *text1 = @"您可以尝试以下操作\n\n";
//        NSString *text2 = @"1.检查Wi-Fi是否为2.4GHz并且可以上网\n\n2.检查Wi-Fi密码是否正确\n\n3.拔掉电源重新试一次";
        NSString *text2 = [NSString stringWithFormat:@"1.检查Wi-Fi是否为2.4GHz并且可以上网\n\n2.检查Wi-Fi密码是否正确\n\n3.拔掉电源重新试一次\n\n4.%@",self.bindErrorString];
        
        NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",text1,text2]];
        // 改变文字大小
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(0, text1.length-1)];
        
        _label.attributedText = attributedText;
        _label.numberOfLines = 0;
        [_label sizeToFit];
        [self.view addSubview:_label];
    }
    return _label;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_binding_fail"]];
        _imageView.frame = CGRectMake(0, 110, 120, 120);
//        _imageView.top = kAdapterHeight(280);
        _imageView.centerX = self.view.centerX;
        _imageView.layer.contentsGravity =kCAGravityResizeAspectFill;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

@end
