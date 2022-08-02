//
//  YFWaveFormView.m
//  YFSeatCushion
//
//  Created by 王丽珍 on 2021/9/7.
//  Copyright © 2021 王丽珍. All rights reserved.
//

#import "YFWaveFormView.h"

@interface YFWaveFormView ()

@end

@implementation YFWaveFormView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor YFColorWithDarkColor:kRGBACOLOR(45, 45, 45, 0.74) lightColor:kWhiteColor];
        self.backgroundColor = [UIColor whiteColor];
        
        
        self.ecgView = [self createViewWithTitle:@"ECG" color:kRGBCOLOR(227, 53, 22) left:18];
        self.ppgView = [self createViewWithTitle:@"PPG" color:kRGBCOLOR(30, 175, 28) left:self.ecgView.right + 20];
        
    }
    return self;
}

- (UIView *)createViewWithTitle:(NSString *)title color:(UIColor *)color left:(CGFloat)left
{
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(left, 0, 80, 45);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, 20, view.height);
    titleLabel.text = title;
    titleLabel.textColor = kRGBCOLOR(18,18,18);
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.width = [titleLabel.text sizeWithAttributes:@{NSFontAttributeName:titleLabel.font}].width + 5;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.right + 5, 0 , 16 , 2.5)];
    line.backgroundColor = color;
    
    titleLabel.centerY = view.centerY;
    line.centerY = view.centerY;
    
    [view addSubview:titleLabel];
    [view addSubview:line];
    
    [self addSubview:view];
    
    return view;
}


@end
