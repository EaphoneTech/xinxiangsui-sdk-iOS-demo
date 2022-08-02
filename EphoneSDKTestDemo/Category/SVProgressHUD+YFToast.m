//
//  SVProgressHUD+YFToast.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/2.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "SVProgressHUD+YFToast.h"

@implementation SVProgressHUD (YFToast)

/// loading
/// @param text 加载内容
+ (void)loadingWithText:(NSString *)text
{
    [self customUI];
    [self showWithStatus:text];
}


/// 错误toast
/// @param text 文字提示
+ (void)showErrorWithText:(NSString *)text
{
    if (!text) return;
    
    [self customUI];
    
    [self showImage:[UIImage imageNamed:@"icon_Crying face"] status:text];
}


/// 成功toast
/// @param text 文字提示
+ (void)showSuccessWithText:(NSString *)text
{
    [self customUI];
    
    [self showImage:[UIImage imageNamed:@"icon_yes"] status:text];
}


/// 自定义图片toast
/// @param image 图片
/// @param text 文字提示
+ (void)showWithImage:(NSString *)image text:(NSString *)text
{
    [self customUI];
    [self showImage:[UIImage imageNamed:image] status:text];
}


/// 自定义背景、文字 颜色 toast
/// @param bgdark dark 背景颜色
/// @param bglight light 背景颜色
/// @param fgdark dark文字颜色
/// @param fglight light 文字颜色
+ (void)showWithBgDarkColor:(UIColor *)bgdark BgLightColor:(UIColor *)bglight fgDarkColor:(UIColor *)fgdark fgLightColor:(UIColor *)fglight
{
    [self setMinimumDismissTimeInterval:2.0];
    [self setMaximumDismissTimeInterval:2.0];
    
    //    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor whiteColor]];
}


//自定义UI
+ (void)customUI
{
    [self setMinimumDismissTimeInterval:2.0];
    [self setMaximumDismissTimeInterval:2.0];
    
    //    [self setDefaultStyle:SVProgressHUDStyleDark];
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    [self setBackgroundColor:[UIColor blackColor]];
    [self setForegroundColor:[UIColor whiteColor]];
}


- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
}


@end
