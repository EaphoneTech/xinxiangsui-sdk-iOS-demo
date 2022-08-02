//
//  ConnectView.m
//  SeatCushion
//
//  Created by eaphone on 17/8/29.
//  Copyright © 2017年 SeatCushion-user. All rights reserved.
//

#import "YFConnectView.h"

@interface YFConnectView ()

@property (nonatomic, strong) UIView *stepOne;
@property (nonatomic, strong) UIView *stepTwo;
@property (nonatomic, strong) UIView *stepThree;

@end

@implementation YFConnectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadUI];
        
    }
    return self;
}


- (void)loadUI{
    self.wifiLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, kScreenW - 40, 40)];
    [self addSubview:self.wifiLabel];
    self.wifiLabel.textAlignment = NSTextAlignmentCenter;
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"device_matong"]];
    self.imageView.frame = CGRectMake(0, self.wifiLabel.bottom + 20, 150, 150);
    self.imageView.centerX = self.centerX;
    [self addSubview:self.imageView];
    
    
    self.nameLab =  [[UILabel alloc] initWithFrame:CGRectMake(20, self.imageView.bottom + 20, kScreenW - 40, 40)];
    self.nameLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.nameLab];
    
    
    self.stepOne =  [self createView:@"连接设备中..."];
    self.stepTwo =  [self createView:@"向设备传输信息中..."];
    self.stepThree =  [self createView:@"设备连接网络成功"];
    
    self.stepTwo.centerX = self.centerX;
    self.stepOne.left = self.stepTwo.left;
    self.stepThree.left = self.stepTwo.left;
    
    
    self.stepOne.top = self.nameLab.bottom + 20;
    self.stepTwo.top = self.stepOne.bottom;
    self.stepThree.top = self.stepTwo.bottom;
    
    self.stepOne.hidden = NO;
    [self imageViewAnimationInView:self.stepOne isStart:YES title:@"连接设备中..."];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30, 0, kScreenW - 60, 2)];
    self.progressView.top = kScreenH - 150;
    self.progressView.trackTintColor = kRGBCOLOR(210, 210, 210);
    self.progressView.progressTintColor = kRGBCOLOR(0, 167, 175);
    [self addSubview:self.progressView];
    
    self.connectTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, self.progressView.bottom + 10, kScreenW - 60, 20)];
    self.connectTitle.text = @"请确保设备和网络稳定";
    self.connectTitle.textAlignment = NSTextAlignmentCenter;
    self.connectTitle.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.connectTitle];
    
}

- (void)setConnectStep:(YFConnectStep)connectStep
{
    switch (connectStep) {
        case YFConnectStepOne:
        {
//            [self.stepOne setImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateNormal];
            [self imageViewAnimationInView:self.stepOne isStart:NO title:@"连接设备成功"];
            self.stepTwo.hidden = NO;
            self.stepThree.hidden = YES;
            [self imageViewAnimationInView:self.stepTwo isStart:YES title:@"向设备传输信息中..."];
        }
            break;
        case YFConnectStepTwo:
        {
//            [self.stepTwo setImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateNormal];
            [self imageViewAnimationInView:self.stepTwo isStart:NO title:@"向设备传输信息成功"];
            self.stepThree.hidden = NO;
            [self imageViewAnimationInView:self.stepThree isStart:YES title:@"设备连接网络成功"];
        }
            break;
        case YFConnectStepThree:
        {
//            [self.stepThree setImage:[UIImage imageNamed:@"duihao"] forState:UIControlStateNormal];
            [self imageViewAnimationInView:self.stepThree isStart:NO title:@"设备连接网络成功"];
        }
            break;
            
        default:
            break;
    }
}

- (UIView *)createView:(NSString *)content
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 0, kScreenWidth - 40, 30)];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [view addSubview:imageV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageV.right, 0, 0, 20)];
    label.text = content;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = kRGBCOLOR(195, 195, 195);
    [view addSubview:label];
    
    CGFloat labelW = [label textRectForBounds:CGRectMake(0, 0, kScreenW, 1000) limitedToNumberOfLines:0].size.width + 10;
    label.width = labelW;
    label.textAlignment = NSTextAlignmentCenter;
    
    view.width = imageV.width + labelW;
    
    [self addSubview:view];
    
    view.hidden = YES;
    
    return view;
}

- (void)imageViewAnimationInView:(UIView *)view isStart:(BOOL)isStart title:(NSString *)title
{
    NSArray *subviews = view.subviews;
    for (int i = 0; i < subviews.count; i ++) {
        if ([subviews[i] isKindOfClass:[UIImageView class]]) {  //图片
            UIImageView *imageView = (UIImageView *)subviews[i];
            
            if (isStart) {
                imageView.image = [UIImage imageNamed:@"icon_connecting"];
                [self startAnimation:imageView];
            } else {
                [self stopAnimation:imageView];
                imageView.image = [UIImage imageNamed:@"icon_binding_success"];
                
            }
        }
        
        if ([subviews[i] isKindOfClass:[UILabel class]]) {   //label text
            UILabel *label = (UILabel *)subviews[i];
            
            label.text = title;
        }
    }
}

- (void)startAnimation:(UIImageView *)imageView
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 1.0;
    animation.byValue = @(M_PI * 2);
    animation.repeatCount = FLT_MAX;
    
    animation.removedOnCompletion = NO;
    
    [imageView.layer addAnimation:animation forKey:@"rotateAnimation"];
}

- (void)stopAnimation:(UIImageView *)imageView
{
    [imageView.layer removeAnimationForKey:@"rotateAnimation"];
}

@end
