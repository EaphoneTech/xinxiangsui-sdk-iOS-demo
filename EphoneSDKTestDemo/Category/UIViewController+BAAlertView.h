//
//  UIViewController+BAAlertView.h
//  BAAlertTest
//
//  Created by 博爱 on 16/2/26.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IOS8x ([[[UIDevice currentDevice] systemVersion] integerValue] >= 8)
#define IOS9m ([[[UIDevice currentDevice] systemVersion] integerValue] < 9)
#define IOS11x ([[[UIDevice currentDevice] systemVersion] integerValue] >= 11)

#define NO_USE -1000

typedef void(^click)(NSInteger index);
typedef void(^configuration)(UITextField *field, NSInteger index);
typedef void(^clickHaveField)(NSArray<UITextField *> *fields, NSInteger index);

@interface UIViewController (BAAlertView)
<
UIAlertViewDelegate,
UIActionSheetDelegate
>

/*!
 *  use alert
 *
 *  @param title    title
 *  @param message  message
 *  @param others   other button title
 *  @param animated animated
 *  @param click    button action
 */
- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
                animated:(BOOL)animated
                  action:(click)click;


//自定义按钮颜色
- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
        button1TextColor:(UIColor *)color1
        button2TextColor:(UIColor *)color2
                animated:(BOOL)animated
                  action:(click)click
                   align:(NSTextAlignment)align;


/*!
 *  use alert
 *
 *  @param title    title
 *  @param message  message
 *  @param others   other button title
 *  @param animated animated
 *  @param click    button action
 */
- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
                animated:(BOOL)animated
                  action:(click)click
                   align:(NSTextAlignment)align;

/*!
 *  use action sheet(对按钮应用警示性样式，提示用户这样做可能会删除或者改)
 *
 *  @param title             title
 *  @param message           message just system verson max or equal 8.0.
 *  @param destructive       button title is red color
 *  @param destructiveAction destructive action
 *  @param others            other button
 *  @param animated          animated
 *  @param click             other button action
 */
- (void)BAActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                   destructive:(NSString *)destructive
             destructiveAction:(click )destructiveAction
                     andOthers:(NSArray <NSString *> *)others
                      animated:(BOOL )animated
                        action:(click )click;

/*!
 *  use action sheet(对按钮应用取消样式，即取消操作)
 *
 *  @param title             title
 *  @param message           message just system verson max or equal 8.0.
 *  @param cancel            cancel button
 *  @param cancelAction      cancelAction action
 *  @param others            other button
 *  @param animated          animated
 *  @param click             other button action
 */
- (void)BAActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                        cancel:(NSString *)cancel
                  cancelAction:(click)cancelAction
                     andOthers:(NSArray <NSString *> *)others
                      animated:(BOOL)animated
                        action:(click)click;

/*!
 *  use alert include textField
 *
 *  @param title         title
 *  @param message       message
 *  @param buttons       buttons
 *  @param number        number of textField
 *  @param configuration configuration textField property
 *  @param animated      animated
 *  @param click         button action
 */
- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
                 buttons:(NSArray<NSString *> *)buttons
         textFieldNumber:(NSInteger )number
           configuration:(configuration )configuration
                animated:(BOOL )animated
                  action:(clickHaveField )click;
@end
