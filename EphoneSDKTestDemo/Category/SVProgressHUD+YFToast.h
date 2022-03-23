//
//  SVProgressHUD+YFToast.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/6/2.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

//NS_ASSUME_NONNULL_BEGIN

@interface SVProgressHUD (YFToast)


/// loading
/// @param text 加载内容
+ (void)loadingWithText:(NSString *)text;


/// 错误toast
/// @param text 文字提示
+ (void)showErrorWithText:(NSString *)text;


/// 成功toast
/// @param text 文字提示
+ (void)showSuccessWithText:(NSString *)text;

/// 自定义图片toast
/// @param image 图片
/// @param text 文字提示
+ (void)showWithImage:(NSString *)image text:(NSString *)text;

/// 自定义背景、文字 颜色 toast
/// @param bgdark dark 背景颜色
/// @param bglight light 背景颜色
/// @param fgdark dark文字颜色
/// @param fglight light 文字颜色
+ (void)showWithBgDarkColor:(UIColor *)bgdark BgLightColor:(UIColor *)bglight fgDarkColor:(UIColor *)fgdark fgLightColor:(UIColor *)fglight;

@end

//NS_ASSUME_NONNULL_END
