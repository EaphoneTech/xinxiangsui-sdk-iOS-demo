//
//  YFMQTTClient.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/10/15.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFMqttServerModel.h"

//NS_ASSUME_NONNULL_BEGIN

@interface YFMQTTClient : NSObject

@property (nonatomic, strong) YFMqttServerModel *model;

+ (instancetype)shareTool;

//获取mqtt服务器信息
- (void)getmqttServer:(NSString *)serial_number;

- (void)initMQTTClient:(NSString *)serial_number;

- (void)disConnect;

- (void)sendData:(NSData *)data;



@end

//NS_ASSUME_NONNULL_END
