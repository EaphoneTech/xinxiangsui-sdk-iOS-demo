//
//  YFTextField.m
//  SeatCushion
//
//  Created by 王丽珍 on 2020/4/17.
//  Copyright © 2020 SeatCushion-user. All rights reserved.
//

#import "YFTextField.h"

@interface YFTextField ()<UITextFieldDelegate>
/**
 *  上次输入的字符
 */
@property (nonatomic, copy) NSString *lastText;

@end

@implementation YFTextField

- (instancetype)init
{
    if (self = [super init]) {
        self.tintColor = kRGBCOLOR(0, 167, 175);
        }
        return self;
}


/**
 *  字符数限制
 */
- (void)setCharacterlimit:(NSInteger)characterlimit
{
    _characterlimit = characterlimit;
    if (_characterlimit > 0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    }else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }

}


-(void)textFieldDidChange:(NSNotification*)obj{
    NSAttributedString* toBeString = self.attributedText;
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    NSString *lang = [self.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        
        UITextRange *selectedRange = [self markedTextRange];
        
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length >= _characterlimit) {
                
                self.attributedText = [toBeString attributedSubstringFromRange:NSMakeRange(0, _characterlimit)];
                // [Toast showWithText:@"输入内容不超过十个字"];
            }
        }else{
            
        }
    }
    
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > _characterlimit) {
            
            self.attributedText = [toBeString attributedSubstringFromRange:NSMakeRange(0, _characterlimit)];
            //            [Toast showWithText:@"输入内容不超过十个字"];
        }
    }
}

/**
 *  统计字符数，汉字占两字符
 */
-(int)getStrLengthWithCh2En1:(NSString *)str
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [str dataUsingEncoding:enc];
    return (int)[da length];
}


- (void)deleteBackward
{
    [super deleteBackward];
    
    if (self.YF_delegate && [self.YF_delegate respondsToSelector:@selector(YFDeleteBackward:)]) {
        [self.YF_delegate YFDeleteBackward:self];
    }
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    
    if (_leftViewBounds.origin.x > 0 || _leftViewBounds.origin.y > 0 || _leftViewBounds.size.width > 0 || _leftViewBounds.size.height) {
        return _leftViewBounds;

    }else {
//        bounds.origin.x = 0;
//        bounds.origin.y = 0;
//        bounds.size.width = kAdapterWidth(120);
//        bounds.size.height = self.height;
        [super leftViewRectForBounds: bounds];
        return bounds;
        
    }
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    if (_rightViewBounds.origin.x > 0 || _rightViewBounds.origin.y > 0 || _rightViewBounds.size.width > 0 || _rightViewBounds.size.height) {
            return _rightViewBounds;
        }else {
            return bounds;
        }
}

//
////编辑位置添加左边距
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    CGRect rect = [super editingRectForBounds:bounds];
//    CGRect inset = CGRectMake(rect.origin.x + self.margin, rect.origin.y, rect.size.width - self.margin, rect.size.height);
//    return inset;
//}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
