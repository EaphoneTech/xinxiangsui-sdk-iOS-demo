//
//  UIViewController+BAAlertView.m
//  BAAlertTest
//
//  Created by 博爱 on 16/2/26.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIViewController+BAAlertView.h"
#import "AppDelegate.h"

//#ifdef IOS8x
//
//#else
static click clickIndex = nil;
static clickHaveField clickIncludeFields = nil;
static click clickDestructive = nil;
//#endif

static NSMutableArray *fields = nil;

@implementation UIViewController (BAAlertView)


#pragma mark - *****  alert view

- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
                animated:(BOOL)animated
                  action:(click)click
{
    [self BAAlertWithTitle:title message:message andOthers:others animated:animated action:click align:NSTextAlignmentCenter];
}

//自定义按钮颜色
- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
        button1TextColor:(UIColor *)color1
        button2TextColor:(UIColor *)color2
                animated:(BOOL)animated
                  action:(click)click
                   align:(NSTextAlignment)align
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
            if (title) {
                
                //改变title的大小和颜色
 //               NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
 //               [titleAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
 //               [titleAtt addAttribute:NSForegroundColorAttributeName value:kcolor_181818 range:NSMakeRange(0, title.length)];
 //               [alertController setValue:titleAtt forKey:@"attributedTitle"];
            }
            
            if (message) {
                //改变message的大小和颜色
                NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
                [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, message.length)];
                [messageAtt addAttribute:NSForegroundColorAttributeName value:kRGBCOLOR(140, 140, 140) range:NSMakeRange(0, message.length)];
                [alertController setValue:messageAtt forKey:@"attributedMessage"];

                if (align != NSTextAlignmentCenter) {
                    [self recursiveLabelViewInView:alertController.view withAlign:align];
                }
            }
            
            [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == 0)
                {
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (action)
                        {
                            click(idx);
                        }
                    }];
                    
                    [okAction setValue:color1 forKey:@"_titleTextColor"];
                    
                    [self setAlertActionColor:okAction];
                    [alertController addAction:okAction];
                    
                    
                }
                else
                {
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (action)
                        {
                            click(idx);
                        }
                    }];
                    
                    [cancelAction setValue:color2 forKey:@"_titleTextColor"];
                    [self setAlertActionColor:cancelAction];
                    [alertController addAction:cancelAction];
                    
                }
            }];
            
 //           alertController.view.tintColor = kRGBACOLOR(50, 50, 50, 1);
        if (@available(iOS 13.0, *)) {
            [self presentViewController:alertController animated:YES completion:nil];
        } else {
            UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            alertWindow.rootViewController = [UIViewController new];
            
            UIWindow *topWindow = [UIApplication sharedApplication].windows.firstObject;
            alertWindow.windowLevel = topWindow.windowLevel + 1;
            [alertWindow makeKeyAndVisible];
            
            [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
     
            
 //       }
 //       else
 //       {
 //           UIAlertView *alertView = nil;
 //           if (others.count > 0)
 //           {
 //               alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:others[0] otherButtonTitles: nil];
 //           }
 //           else
 //           {
 //               alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
 //           }
 //
 //
 //           [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
 //
 //               if (idx != 0)
 //               {
 //                   [alertView addButtonWithTitle:obj];
 //               }
 //           }];
 //
 //           clickIndex = click;
 //           NSLog(@"alertView.subviews:%@",alertView.subviews);
 //           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 //               [alertView show];
 //           });
 //
 //       }
    });
     
}


- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
               andOthers:(NSArray<NSString *> *)others
                animated:(BOOL)animated
                  action:(click)click
                   align:(NSTextAlignment)align
{
   dispatch_async(dispatch_get_main_queue(), ^{
       
//       if (IOS8x)
//       {
           UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
       
       
       
       
           //        alertController.tintColor = [UIColor blackColor];
           if (title) {
               
               //改变title的大小和颜色
//               NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
//               [titleAtt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, title.length)];
//               [titleAtt addAttribute:NSForegroundColorAttributeName value:kcolor_181818 range:NSMakeRange(0, title.length)];
//               [alertController setValue:titleAtt forKey:@"attributedTitle"];
           }
           
           if (message) {
               //改变message的大小和颜色
               NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
               [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, message.length)];
               [messageAtt addAttribute:NSForegroundColorAttributeName value:kRGBCOLOR(140, 140, 140) range:NSMakeRange(0, message.length)];
               [alertController setValue:messageAtt forKey:@"attributedMessage"];

               if (align != NSTextAlignmentCenter) {
                   [self recursiveLabelViewInView:alertController.view withAlign:align];
               }
           }
           
           [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
               if (idx == 0)
               {
                   
                   UIAlertAction *okAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       if (action)
                       {
                           click(idx);
                       }
                   }];
                   
                   if (others.count == 1) { //只有一个按钮
                       [okAction setValue:kRGBCOLOR(0, 167, 175) forKey:@"_titleTextColor"];
                   } else {
                       [okAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
                   }
                   
                   [self setAlertActionColor:okAction];
                   [alertController addAction:okAction];
                   
                   
               }
               else
               {
                   
                   UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                       if (action)
                       {
                           click(idx);
                       }
                   }];
                   
                   [cancelAction setValue:kRGBCOLOR(0, 167, 175) forKey:@"_titleTextColor"];
                   [self setAlertActionColor:cancelAction];
                   [alertController addAction:cancelAction];
                   
               }
           }];
           
//           alertController.view.tintColor = kRGBACOLOR(50, 50, 50, 1);
       if (@available(iOS 13.0, *)) {
           [self presentViewController:alertController animated:YES completion:nil];
       } else {
           UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
           alertWindow.rootViewController = [UIViewController new];
           
           UIWindow *topWindow = [UIApplication sharedApplication].windows.firstObject;
           alertWindow.windowLevel = topWindow.windowLevel + 1;
           [alertWindow makeKeyAndVisible];
           
           [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
       }
    
           
//       }
//       else
//       {
//           UIAlertView *alertView = nil;
//           if (others.count > 0)
//           {
//               alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:others[0] otherButtonTitles: nil];
//           }
//           else
//           {
//               alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
//           }
//
//
//           [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//               if (idx != 0)
//               {
//                   [alertView addButtonWithTitle:obj];
//               }
//           }];
//
//           clickIndex = click;
//           NSLog(@"alertView.subviews:%@",alertView.subviews);
//           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//               [alertView show];
//           });
//
//       }
   });
    
}



-(void)setAlertActionColor:(id)alertActtion
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UIAlertAction class], &count);
    for(int i =0;i < count;i ++){
        
        Ivar ivar = ivars[i];
        NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        
        if ([ivarName isEqualToString:@"_titleTextColor"]) {
            
//            [alertActtion setValue:kColorTheme forKey:@"titleTextColor"];
        }
    }
}

- (void)recursiveLabelViewInView:(UIView *)view withAlign:(NSTextAlignment)align
{
    UILabel *messageLab;
    
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
//            UILabel *label = (UILabel*)subView;
//            label.textAlignment = align;
            messageLab = (UILabel*)subView;
        } else {
            [self recursiveLabelViewInView:subView withAlign:align];
        }
    }
    messageLab.textAlignment = align;
}

#pragma mark - *****  alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (clickIndex)
    {
        clickIndex(buttonIndex);
    }
    else if (clickIncludeFields)
    {
        clickIncludeFields(fields,buttonIndex);
    }
    
    clickIndex = nil;
    clickIncludeFields = nil;
}

#pragma mark - *****  sheet  警示式样
- (void)BAActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                   destructive:(NSString *)destructive
             destructiveAction:(click )destructiveAction
                     andOthers:(NSArray <NSString *> *)others
                      animated:(BOOL )animated
                        action:(click )click
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (IOS8x)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            
            if (destructive)
            {
                [alertController addAction:[UIAlertAction actionWithTitle:destructive style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    if (action)
                    {
                        destructiveAction(NO_USE);
                    }
                }]];
            }
            
            if (title) {
                
//                //改变title的大小和颜色
//                NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
//                [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
//                [titleAtt addAttribute:NSForegroundColorAttributeName value:kRGBACOLOR(50, 50, 50, 1) range:NSMakeRange(0, title.length)];
//                [alertController setValue:titleAtt forKey:@"attributedTitle"];
            }
            
            if (message) {
                //改变message的大小和颜色
//                NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
//                [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, message.length)];
//                [messageAtt addAttribute:NSForegroundColorAttributeName value:kRGBACOLOR(50, 50, 50, 1) range:NSMakeRange(0, message.length)];
//                [alertController setValue:messageAtt forKey:@"attributedMessage"];
            }
            
            [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0)
                {
                    [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (action)
                        {
                            click(idx);
                        }
                    }]];
                }
                else
                {
                    [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (action)
                        {
                            click(idx);
                        }
                    }]];
                }
                
            }];
//            alertController.view.tintColor = kRGBACOLOR(50, 50, 50, 1);
            [self presentViewController:alertController animated:animated completion:nil];
        }
        else
        {
            UIActionSheet *sheet = nil;
            if (others.count > 0 && destructive)
            {
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:others[0] destructiveButtonTitle:destructive otherButtonTitles:nil];
            }
            else
            {
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:destructive otherButtonTitles:nil];
            }
            
            [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx != 0)
                {
                    [sheet addButtonWithTitle:obj];
                }
            }];
            clickIndex = click;
            clickDestructive = destructiveAction;
            [sheet showInView:self.view];
        }

    });
    }

#pragma mark - *****  sheet2 取消式样
- (void)BAActionSheetWithTitle:(NSString *)title
                       message:(NSString *)message
                        cancel:(NSString *)cancel
                  cancelAction:(click)cancelAction
                     andOthers:(NSArray <NSString *> *)others
                      animated:(BOOL)animated
                        action:(click)click

{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (IOS8x)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            
            if (cancel)
            {
                [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    if (action)
                    {
                        cancelAction(NO_USE);
                    }
                }]];
            }
            
            if (title) {
                
//                //改变title的大小和颜色
//                NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
//                [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
//                [titleAtt addAttribute:NSForegroundColorAttributeName value:kRGBACOLOR(50, 50, 50, 1) range:NSMakeRange(0, title.length)];
//                [alertController setValue:titleAtt forKey:@"attributedTitle"];
            }
            
            if (message) {
                //改变message的大小和颜色
//                NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
//                [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, message.length)];
//                [messageAtt addAttribute:NSForegroundColorAttributeName value:kRGBACOLOR(50, 50, 50, 1) range:NSMakeRange(0, message.length)];
//                [alertController setValue:messageAtt forKey:@"attributedMessage"];
            }
            
            [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx == 0)
                {
                    [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        if (action)
                        {
                            click(idx);
                        }
                    }]];
                }
                else
                {
                    [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (action)
                        {
                            click(idx);
                        }
                    }]];
                }
                
            }];
//            alertController.view.tintColor = kRGBACOLOR(50, 50, 50, 1);
            [self presentViewController:alertController animated:animated completion:nil];
        }
        else
        {
            UIActionSheet *sheet = nil;
            if (others.count > 0 && cancel)
            {
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:others[0] destructiveButtonTitle:cancel otherButtonTitles:nil];
            }
            else
            {
                sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:cancel otherButtonTitles:nil];
            }
            
            [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (idx != 0)
                {
                    [sheet addButtonWithTitle:obj];
                }
            }];
            clickIndex = click;
            clickDestructive = cancelAction;
            [sheet showInView:self.view];
        }
        
    });
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        if (clickDestructive)
        {
            clickDestructive(NO_USE);
        }
    }
    else
    {
        if (clickIndex)
        {
            clickIndex(buttonIndex - 1);
        }
    }
}

#pragma mark - *****  textField
- (void)BAAlertWithTitle:(NSString *)title
                 message:(NSString *)message
                 buttons:(NSArray<NSString *> *)buttons
         textFieldNumber:(NSInteger )number
           configuration:(configuration )configuration
                animated:(BOOL )animated
                  action:(clickHaveField )click
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        if (fields == nil)
    {
        fields = [NSMutableArray array];
    }
    else
    {
        [fields removeAllObjects];
    }
    
    if (IOS8x)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        // textfield
        for (NSInteger i = 0; i < number; i++)
        {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.height =textField.height+10;
                [fields addObject:textField];
                configuration(textField,i);
            }];
        }
        if (title) {
            
            //改变title的大小和颜色
//            NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:title];
//            [titleAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, title.length)];
//            [titleAtt addAttribute:NSForegroundColorAttributeName value:kRGBACOLOR(50, 50, 50, 1) range:NSMakeRange(0, title.length)];
//            [alertController setValue:titleAtt forKey:@"attributedTitle"];
        }
       
        if (message) {
            //改变message的大小和颜色
//            NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
//            [messageAtt addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, message.length)];
//            [messageAtt addAttribute:NSForegroundColorAttributeName value:kRGBACOLOR(50, 50, 50, 1) range:NSMakeRange(0, message.length)];
//            [alertController setValue:messageAtt forKey:@"attributedMessage"];
        }
       
        // button
        [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0)
            {
                [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (action)
                    {
                        click(fields,idx);
                    }
                }]];
                
            }
            else
            {
                [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    if (action)
                    {
                        click(fields,idx);
                    }
                }]];
            }
        }];
//        alertController.view.tintColor = kRGBACOLOR(50, 50, 50, 1);
        [self presentViewController:alertController animated:animated completion:nil];
    }
    else
    {
        UIAlertView *alertView = nil;
        if (buttons.count > 0)
        {
            alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:buttons[0] otherButtonTitles:nil];
        }
        else
        {
            alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        }
        // field
        if (number == 1)
        {
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        }
        else if (number > 2)
        {
            alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        }
        
        // configuration field
        if (alertView.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput)
        {
            [fields addObject:[alertView textFieldAtIndex:0]];
            [fields addObject:[alertView textFieldAtIndex:1]];
            
            configuration([alertView textFieldAtIndex:0],0);
            configuration([alertView textFieldAtIndex:1],1);
        }
        else if(alertView.alertViewStyle == UIAlertViewStylePlainTextInput || alertView.alertViewStyle == UIAlertViewStyleSecureTextInput)
        {
            [fields addObject:[alertView textFieldAtIndex:0]];
            configuration([alertView textFieldAtIndex:0],0);
        }
        
        // other button
        [buttons enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx != 0)
            {
                [alertView addButtonWithTitle:obj];
            }
        }];
        clickIncludeFields = click;
        
        [alertView show];
    }
    });

}


@end
