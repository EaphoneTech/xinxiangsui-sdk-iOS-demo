//
//  YFNetworkDataModel.h
//  SeatCushion
//
//  Created by 王丽珍 on 2020/5/19.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFNetworkDataModel : NSObject

@property (nonatomic, copy) NSString *success;

@property (nonatomic, copy) NSString *errcode;

@property (nonatomic, copy) NSString *message;

@property (nonatomic ,strong) id data;

/// 当前页数
@property (nonatomic, assign) int page_index;

/// 每页条数
@property (nonatomic, assign) int page_size;

/// 总页数
@property (nonatomic, assign) int total_record;

/// 是否已到最后一页
- (BOOL)isEnd;

@end

NS_ASSUME_NONNULL_END
