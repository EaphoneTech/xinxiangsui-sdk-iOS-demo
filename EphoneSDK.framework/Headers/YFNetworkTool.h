//
//  YFNetworkTool.h
//  SeatCushion
//
//  Created by 王丽珍 on 2020/5/19.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

enum YFErrCode {
     YFErrCodeRequestMethodError = 8000001,   //HTTP请求方式不正确
     YFErrCodeRequestHeaderError = 8000002,    //HTTP请求头不合法
     YFErrCodeRequestParametersError = 8000003,   //HTTP请求参数不合法
     YFErrCodeRequestContentError = 8000004,    //HTTP请求内容不合法
     
     YFErrCodeAppidOrSecretError = 8001001,    //APPID或Secret不正确
     YFErrCodeTokenInvalid = 8001003,   //AccessToken失效
     
     YFErrCodeUserNotExist = 8002001,   //用户不存在
     YFErrCodeUserRegisterFail = 8002002,    //用户注册失败
     YFErrCodeUserUpdateFailed = 8002003,   //用户更新失败
     
     YFErrCodeDeviceNotExist = 8003001,   //设备不存在
     YFErrCodeDeviceBeBound = 8003101,   //设备已绑定
     YFErrCodeDeviceBindingFail = 8003102,   //设备绑定失败
     YFErrCodeDeviceUnbound = 8003201,    //设备已解绑
     YFErrCodeDeviceCanNotUnboundByOthers = 8003202,    //设备无法被其他人解绑
     YFErrCodeDeviceUnbindFail = 8003203,    //设备解绑失败
     
     
     YFErrCodeHealthDataNotExit = 8004001,  //健康数据不存在
     YFErrCodeHealthDataUploading = 8004002,   //健康数据上传中
     YFErrCodeHealthDataTimeShort = 8004003,   //健康数据时长不够
     YFErrCodeHealthDataUnderAnalysis = 8004004,   //健康数据分析中
     
     YFErrCodeSetDeviceUserFail = 8005001,   //无法设置设备使用者（建议重试）
     YFErrCodeMarkUserFailed = 8005101,   //手动标记用户失败（建议重试）
     YFErrCodeProductNotExist = 8006001,   //产品不存在
     YFErrCodeServerError = 8000000,   //服务端错误（请联系售后支撑人员）
};

/**
网路请求成功回调

@param responseObject data
*/
typedef void(^YFRequestSuccessBlock)(id responseObject);

/**
网路请求失败回调

@param error 错误对象
@param errorDes 错误原因
*/
typedef void(^YFRequestFailureBlock)(NSError *error, NSString *errorDes);

@interface YFNetworkTool : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

+(instancetype)shareTool;


@end

