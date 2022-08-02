//
//  YFECGCoverView.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2021/7/6.
//  Copyright © 2021 王丽珍. All rights reserved.
//

#import "YFECGCoverView.h"

@interface YFECGCoverView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation YFECGCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kRGBACOLOR(18, 18, 18, 0.7);
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _messageLabel.centerY = frame.size.height / 2 + 15;
    _titleLabel.bottom = _messageLabel.top;
}

- (void)setTipString:(NSString *)tipString
{
    _tipString = tipString;
    
    _messageLabel.text = tipString;
    _messageLabel.numberOfLines = 0;
    [_messageLabel sizeToFit];
    
    _messageLabel.centerY = self.height / 2 + 15;
    _titleLabel.bottom = _messageLabel.top;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, 60, self.width - 84, 25)];
        _titleLabel.text = @"温馨提示";
        _titleLabel.textColor = kRGBCOLOR(255, 87, 87);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _titleLabel;
}

- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(42, self.titleLabel.bottom + 10, self.width - 84, 25)];
        _messageLabel.text = @"未检测到有效ECG信号，请挪动臀部调整坐姿或检查皮肤与电极片之间是否有衣物遮挡。";
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.numberOfLines = 0;
        [_messageLabel sizeToFit];
        _messageLabel.width = self.titleLabel.width;
        _messageLabel.centerX = self.width/2;
        _messageLabel.centerY = self.height / 2 + 15;
        _titleLabel.bottom = _messageLabel.top;
        
    }
    return _messageLabel;
}

@end
