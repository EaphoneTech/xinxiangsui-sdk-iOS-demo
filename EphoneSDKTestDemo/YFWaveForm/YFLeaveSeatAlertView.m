//
//  YFLeaveSeatAlertView.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2021/7/6.
//  Copyright © 2021 王丽珍. All rights reserved.
//

#import "YFLeaveSeatAlertView.h"

@interface YFLeaveSeatAlertView ()
{
    UIWindow *window;
}
@property (nonatomic, strong) UIView *bgView;   //蒙版
@property (nonatomic, strong) UIView *alertView;   //弹框操作显示view

@property (nonatomic, strong) UILabel *titleLab;   //标题
@property (nonatomic, strong) UILabel *messageLab;   //内容
@property (nonatomic, strong) UILabel *contentLab;   //内容

@property (nonatomic, strong) UIView *l1;
@property (nonatomic, strong) UIView *l2;

@property (nonatomic, strong) UIButton *exitBtn;   //退出
@property (nonatomic, strong) UIButton *contiuntButton;  //继续检测

@end

@implementation YFLeaveSeatAlertView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        window = [UIApplication sharedApplication].windows[0];
        
        self.bgView.backgroundColor = [UIColor blackColor];
        
    }
    return self;
}


- (void)continueButtonClick
{
    //本地数据保存
    if (self.continueClickBlock) {
        self.continueClickBlock();
    }
    
    self.isShow = NO;
    
    WEAKSELF;
    [UIView animateWithDuration:0 animations:^{
        weakSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.alertView removeFromSuperview];
        [weakSelf.bgView removeFromSuperview];
    }];
}


- (void)exitBtnClick
{
    if (self.exitClickBlock) {
        self.exitClickBlock();
    }
    
    self.isShow = NO;
    
    WEAKSELF;
    [UIView animateWithDuration:0 animations:^{
        weakSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.alertView removeFromSuperview];
        [weakSelf.bgView removeFromSuperview];
    }];
}


- (void)showView
{
    [window addSubview:self];
    
    [self contiuntButton];
    [self exitBtn];
    
    self.isShow = YES;
}

- (void)removeView
{
    self.isShow = NO;
    
    WEAKSELF;
    [UIView animateWithDuration:0 animations:^{
        weakSelf.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf.alertView removeFromSuperview];
        [weakSelf.bgView removeFromSuperview];
    }];
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
        _messageLab.text = @"监测到您已离座，是否退出心电监测？";
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

- (UILabel *)contentLab
{
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] initWithFrame:CGRectMake(35, self.messageLab.bottom + 20, self.alertView.width - 70, 20)];
        _contentLab.text = @"您可以到如厕记录查看本次测量结果或选择继续监测，测量时间低于35s记录将不会上传哦。";
        _contentLab.textColor = kRGBCOLOR(153, 153, 153);
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.numberOfLines = 0;
        [_contentLab sizeToFit];
        _contentLab.centerX = self.titleLab.centerX;
        [self.alertView addSubview:_contentLab];
    }
    return _contentLab;
}

- (UIView *)l1
{
    if (!_l1) {
        _l1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentLab.bottom + 20, self.alertView.width, 1)];
        _l1.backgroundColor = kRGBCOLOR(232, 232, 232);
        [self.alertView addSubview:_l1];
    }
    return _l1;
}

- (UIView *)l2
{
    if (!_l2) {
        _l2 = [[UIView alloc] initWithFrame:CGRectMake(self.alertView.width / 2, self.l1.bottom, 1, self.alertView.height - self.l1.bottom)];
        _l2.backgroundColor = kRGBCOLOR(232, 232, 232);
        [self.alertView addSubview:_l2];
    }
    return _l2;
}


- (UIButton *)exitBtn
{
    if (!_exitBtn) {
        _exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame = CGRectMake(self.alertView.width / 2 + 0.5, self.l1.bottom, self.alertView.width / 2 - 0.5, self.l2.height);
        [_exitBtn setTitle:@"退出" forState:UIControlStateNormal];
        _exitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_exitBtn setTitleColor:kRGBCOLOR(153, 153, 153) forState:UIControlStateNormal];
        [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_exitBtn];
    }
    return _exitBtn;
}

- (UIButton *)contiuntButton
{
    if (!_contiuntButton) {
        _contiuntButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contiuntButton.frame = CGRectMake(0, self.l1.bottom, self.alertView.width / 2 - 0.5, self.l2.height);
        [_contiuntButton setTitle:@"继续检测" forState:UIControlStateNormal];
        _contiuntButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_contiuntButton setTitleColor:kRGBCOLOR(153, 153, 153) forState:UIControlStateNormal];
        [_contiuntButton addTarget:self action:@selector(continueButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_contiuntButton];
    }
    return _contiuntButton;
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
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(30, 100, kScreenW - 60, 230)];
        _alertView.backgroundColor =  [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.clipsToBounds = YES;
        [window addSubview:_alertView];
        _alertView.center = self.bgView.center;
        //        [self addSubview:_alertView];
        
    }
    return _alertView;
}


@end
