//
//  YFMqttServerModel.h
//  YFSeatCushion
//
//  Created by 王丽珍 on 2020/10/15.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFMqttServerModel : NSObject

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *port;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *client_id;


@end

NS_ASSUME_NONNULL_END
