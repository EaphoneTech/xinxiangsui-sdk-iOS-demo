//
//  YFKitCommonCode.h
//  SeatCushion
//
//  Created by 王丽珍 on 2020/4/8.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFCommonCode : NSObject
/**
 判断字符串是否为空
 
 @param string 需要判断的字符串
 @return YES:字符串为空
 */
+ (BOOL) isBlankString:(NSString *)string;

/**
* 判断字符串是否包含空格
*/
+ (BOOL)isContainBlank:(NSString *)str;


//NSData 转字典
+ (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData;


#pragma mark - NSString 转 字典NSDictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END
