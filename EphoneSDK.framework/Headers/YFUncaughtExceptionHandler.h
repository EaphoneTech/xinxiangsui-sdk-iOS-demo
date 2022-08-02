//
//  YFUncaughtExceptionHandler.h
//  EphoneSDK
//
//  Created by 王丽珍 on 2021/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFUncaughtExceptionHandler : NSObject

+ (void)setDefaultHandler;
+ (NSUncaughtExceptionHandler *)getHandler;

@end

NS_ASSUME_NONNULL_END
