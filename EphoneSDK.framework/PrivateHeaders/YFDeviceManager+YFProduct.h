//
//  YFDeviceManager+YFProduct.h
//  EphoneSDK
//
//  Created by 王丽珍 on 2021/11/3.
//

#import <EphoneSDK/EphoneSDK.h>


NS_ASSUME_NONNULL_BEGIN

@interface YFBindInstructionModel : NSObject

@property (nonatomic, strong) NSString *bind_image_url;
@property (nonatomic, strong) NSString *bind_text;
@property (nonatomic, strong) NSString *bind_type;
@property (nonatomic, strong) NSString *confirm_text;
@property (nonatomic, strong) NSString *error_image_url;
@property (nonatomic, strong) NSString *error_text;
@property (nonatomic, strong) NSString *problem_text;
@property (nonatomic, strong) NSString *problem_title;

@end

@interface YFUsageinStruction : NSObject

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *title;

@end

@interface YFDeviceManager (YFProduct)

@property (nonatomic, strong) YFBindInstructionModel *bind_instruction;
@property (nonatomic, assign) NSNumber *bind_status;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray<NSDictionary *> *channels;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *manualUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<NSDictionary *> *sensors;
@property (nonatomic, strong) NSDictionary *supplier;
@property (nonatomic, strong) NSString *thumbnailUrl;
@property (nonatomic ,strong) NSString* usageText;
@property (nonatomic ,strong) NSMutableArray <YFUsageinStruction *> *usage_instruction;

@end

NS_ASSUME_NONNULL_END
