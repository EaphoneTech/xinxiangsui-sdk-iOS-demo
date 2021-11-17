//
//  YFReconnectBleAlertView.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2021/7/6.
//  Copyright © 2021 王丽珍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFReconnectBleAlertView : UIView

@property (nonatomic, assign) BOOL isShow;  //当前弹框是否正在展示

@property (copy, nonatomic)void(^exitClickBlock)(void);

- (void)showView;
- (void)removeView;

@end

NS_ASSUME_NONNULL_END
