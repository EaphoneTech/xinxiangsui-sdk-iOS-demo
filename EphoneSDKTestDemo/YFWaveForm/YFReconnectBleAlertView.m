//
//  YFReconnectBleAlertView.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2021/7/6.
//  Copyright © 2021 王丽珍. All rights reserved.
//

#import "YFReconnectBleAlertView.h"

@interface YFReconnectBleAlertView ()
{
    UIWindow *window;
}
@property (nonatomic, strong) UIView *bgView;   //蒙版
@property (nonatomic, strong) UIView *alertView;   //弹框操作显示view

@property (nonatomic, strong) UILabel *titleLab;   //标题
@property (nonatomic, strong) UILabel *messageLab;   //内容

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;  //菊花

@property (nonatomic, strong) UIButton *exitButton;  //退出


@end

@implementation YFReconnectBleAlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        window = [UIApplication sharedApplication].windows[0];
        
        self.bgView.backgroundColor = [UIColor blackColor];
        [self.alertView addSubview:self.exitButton];
        self.isShow = NO;
        
    }
    return self;
}


- (void)showView
{
    [window addSubview:self];
    
    [self.indicatorView startAnimating];
    
    self.isShow = YES;
}

- (void)removeView
{
    self.isShow = NO;
    [self.indicatorView stopAnimating];
    
    WEAKSELF;
    [UIView animateWithDuration:0 animations:^{
        weakSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.alertView removeFromSuperview];
        [weakSelf.bgView removeFromSuperview];
    }];
}

- (void)exitAction
{
    if (self.exitClickBlock) {
        self.exitClickBlock();
    }
    
    [self removeView];
}


- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.alertView.width - 40, 20)];
        _titleLab.text = @"温馨提示";
        _titleLab.textColor = kRGBCOLOR(18, 18, 18);
        _titleLab.font = [UIFont systemFontOfSize:18];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:_titleLab];
    }
    return _titleLab;
}

- (UILabel *)messageLab
{
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] initWithFrame:CGRectMake(18, self.titleLab.bottom + 20, self.alertView.width - 36, 30)];
        _messageLab.text = @"设备意外断开，正在尝试重连...";
        _messageLab.textColor = kRGBCOLOR(102, 102, 102);
        _messageLab.font = [UIFont systemFontOfSize:16];
        _messageLab.numberOfLines = 0;
        [_messageLab sizeToFit];
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.centerX = self.titleLab.centerX;
        [self.alertView addSubview:_messageLab];
    }
    return _messageLab;
}


- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.top = self.messageLab.bottom + 40;
        _indicatorView.centerX = self.alertView.width/2;
        
        _indicatorView.transform = CGAffineTransformMakeScale(2.5, 2.5);
        _indicatorView.color = kRGBCOLOR(0,167,175);
        _indicatorView.layer.cornerRadius = 20;
        [self.alertView addSubview:_indicatorView];
        
    }
    return _indicatorView;
}

- (UIButton *)exitButton
{
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitButton.frame = CGRectMake(0, self.indicatorView.bottom + 25, self.alertView.width / 2, 44);
        [_exitButton setTitle:@"退出连接" forState:UIControlStateNormal];
        _exitButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:kRGBCOLOR(0,167,175)];
        
        _exitButton.layer.cornerRadius = _exitButton.height / 2;
        
        _exitButton.centerX = self.alertView.width/2;
        [_exitButton addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:window.frame];
        //        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.alpha = 0.3;
        [window addSubview:_bgView];
        //        [self addSubview:_bgView];
    }
    return _bgView;
}


- (UIView *)alertView
{
    if (!_alertView) {
        
        //弹出框
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, kScreenW - 60, 285)];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.clipsToBounds = YES;
        [window addSubview:_alertView];
        _alertView.center = self.bgView.center;
        //        [self addSubview:_alertView];
        
    }
    return _alertView;
}


@end
