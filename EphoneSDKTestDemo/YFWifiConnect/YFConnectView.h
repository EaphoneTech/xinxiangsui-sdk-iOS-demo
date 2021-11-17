//
//  YFConnectView.h
//  SeatCushion
//
//  Created by eaphone on 17/8/29.
//  Copyright © 2017年 SeatCushion-user. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    YFConnectStepOne,
    YFConnectStepTwo,
    YFConnectStepThree,
} YFConnectStep;


@interface YFConnectView : UIView

//wifi名字
@property (nonatomic, strong) UILabel *wifiLabel;

///设备图片
@property (nonatomic, strong) UIImageView *imageView;

//设备名称
@property (nonatomic, strong) UILabel *nameLab;

//进度条
@property (nonatomic, strong) UIProgressView *progressView;

///进度条底部 提示
@property (nonatomic, strong) UILabel *connectTitle;

@property (nonatomic, assign) YFConnectStep connectStep;

@property (nonatomic, assign) BOOL stepOneSueecss;  //第一步是否成功
@property (nonatomic, assign) BOOL stepTwoSueecss;  //第二步是否成功
@property (nonatomic, assign) BOOL stepThreeSueecss;   //第三步是否成功

@end
