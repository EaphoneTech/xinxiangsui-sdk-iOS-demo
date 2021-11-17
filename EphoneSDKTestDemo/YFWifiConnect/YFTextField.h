//
//  YFTextField.h
//  SeatCushion
//
//  Created by 王丽珍 on 2020/4/17.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YFTextField;
@protocol YFTextFieldDelete <NSObject>

- (void)YFDeleteBackward:(YFTextField *)textField;

@end

@interface YFTextField : UITextField

/**
 *  字符数限制
 */
@property (nonatomic, assign) NSInteger characterlimit;

@property (nonatomic, assign) CGRect leftViewBounds;

@property (nonatomic, assign) CGRect rightViewBounds;

@property (nonatomic, assign) CGFloat margin;  //leftview间距

@property (nonatomic, weak) id<YFTextFieldDelete> YF_delegate;

@end

NS_ASSUME_NONNULL_END
