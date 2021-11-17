//
//  YFLeaveSeatAlertView.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2021/7/6.
//  Copyright © 2021 王丽珍. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFLeaveSeatAlertView : UIView

@property(copy, nonatomic)void(^continueClickBlock)(void);
@property (copy, nonatomic)void(^exitClickBlock)(void);


@property (nonatomic, assign) BOOL isShow;  //当前是否已经弹出显示

- (void)continueButtonClick;

- (void)exitBtnClick;

- (void)showView;
- (void)removeView;

@end

NS_ASSUME_NONNULL_END
