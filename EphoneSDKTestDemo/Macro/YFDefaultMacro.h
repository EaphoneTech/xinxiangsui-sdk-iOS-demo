//
//  YFColorMacro.h
//  darkModeDemo
//
//  Created by 王丽珍 on 2020/5/11.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#ifndef YFDefaultMacro_h
#define YFDefaultMacro_h

#define kScreenH     [[UIScreen mainScreen] bounds].size.height
#define kScreenW     [[UIScreen mainScreen] bounds].size.width

#define kRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]



#define WEAKSELF typeof(self) __weak weakSelf = self

#endif /* YFColorMacro_h */
