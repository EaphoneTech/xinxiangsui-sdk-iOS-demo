//
//  YFKitCommonCode.m
//  SeatCushion
//
//  Created by 王丽珍 on 2020/4/8.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import "YFCommonCode.h"
#import <sys/utsname.h>

@implementation YFCommonCode

/**
 判断字符串是否为空
 
 @param string 需要判断的字符串
 @return YES:字符串为空
 */
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


/**
 * 判断字符串是否包含空格
 */
+ (BOOL)isContainBlank:(NSString *)str{
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        NSLog(@"有空格");
        return YES;
    }else {
        //没有空格
        NSLog(@"没有空格");
        return NO;
    }
}

//NSData 转字典
+ (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData
{
    if (![jsonData isKindOfClass:[NSData class]] || jsonData.length < 1) {

        return nil;

    }

    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];

    if (![jsonObj isKindOfClass:[NSDictionary class]]) {

        return nil;

    }

    return [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonObj];

}

#pragma mark - NSString 转 字典NSDictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {/*JSON解析失败*/

        return nil;
    }
    return dic;
}


@end
