//
//  ECGView.m
//  心电图
//
//  Created by 王丽珍 on 2020/12/28.
//  Copyright © 2020 王丽珍. All rights reserved.
//

#import "ECGView.h"

@implementation ECGView 

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if ( EcgViewScreenWidth > 380) {
            _pixelsPerCell = k6pmm; // 0.2 second per cell
        } else {
            _pixelsPerCell = k1mm;  // 0.2 second per cell
        }
        //设置相关属性
        self.clipsToBounds = YES;
        
        self.amplitude = 0.4;
        self.pointMartin = 1;
//        self.maxI = self.width/3;
        self.penBrushWidth = 1.5;
        self.layer.borderWidth = 1;
//        self.layer.cornerRadius = 8;
        self.drawNumbers = 0;
        
        self.drawerColor = kRGBCOLOR(72, 90, 71);
        self.backgroundColor = [UIColor blackColor];
        self.layer.borderColor = [[UIColor clearColor] CGColor];
        
        //绘制心电图的背景格子
//        [self drawGrid];
        [self clearButton];
    }
    return self;
}

//初始化贝塞尔路径
- (UIBezierPath *)bezierpath {
    if (!_bezierpath) {
        _bezierpath = [[UIBezierPath alloc] init];
    }
    return _bezierpath;
}

//初始化shapelayer对象
- (CAShapeLayer *)shapelayer {
    if (!_shapelayer) {
        _shapelayer = [CAShapeLayer layer];
    }
    return _shapelayer;
}

//初始化数组
- (NSMutableArray *)lineArray {
    if (_lineArray == nil) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

// 外部设置数组。在这个方法中启动了定时器，开始对外部的数组进行数据的处理
- (void)setEcgArray:(NSMutableArray *)ecgArray {
    
    
    
//    if ((_drawNumbers < _ecgArray.count-1) && (_ecgArray.count > 1)) {
//        [_ecgArray removeObjectsInRange:NSMakeRange(0, _drawNumbers + 1)];
//        [_ecgArray addObjectsFromArray:ecgArray];
//    } else {
//        _ecgArray = ecgArray;
//    }
    
//    _ecgArray = ecgArray;
    
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    if (_ecgArray.count) {
        for (int i = 0; i < _ecgArray.count; i ++) {
            [tempArr addObject:_ecgArray[i]];
        }
    }
    [tempArr addObjectsFromArray:ecgArray];
    
//    NSLog(@" tempArr.count === %ld",tempArr.count);
    
    _ecgArray = tempArr;

//    NSLog(@" _ecgArray.count === %ld",tempArr.count);

    _maxI = self.width / self.pointMartin;
    _drawNumbers = 0;
    
    //开启定时器
    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(drawCurve) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
//        [[NSRunLoop currentRunLoop] run];
        
        __block ECGView *blockSelf = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            blockSelf->_timer=[NSTimer scheduledTimerWithTimeInterval:1.000/self.ecgArray.count
                                                    target:blockSelf
                                                selector:@selector(drawCurve)
                                                  userInfo:nil
                                                   repeats:YES] ;
            [[NSRunLoop currentRunLoop] addTimer:blockSelf->_timer forMode:NSDefaultRunLoopMode];
            [[NSRunLoop currentRunLoop] run];
             });
    }
}

//清空重制
- (void)clearButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 35, 35);
    [btn setImage:[UIImage imageNamed:@"freshen.jpg"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearAllEcgPoint) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}
//绘制折线
- (void)drawCurve {
    
    WEAKSELF;
    dispatch_async(dispatch_get_main_queue(), ^{
        //清除掉bezierpath原来的所有坐标点
        [weakSelf.bezierpath removeAllPoints];
        
        /*  ----------------这一段的数组操作逻辑是我在别人博客中ECGDemo里面的逻辑-------------
            blog.csdn地址：http://blog.csdn.net/iosyangming/article/details/50977395
         对需要绘制的self.lineArray数组的操作，在绘制没有满self的宽度时：
            每次从_ecgArray数组中取出addNumber（最好是能整除你传入的数组的整数，避免数据丢失）个元素添加到self.lineArray数组中去，
         当数组元素个数大于self横屏能容纳的_maxI时：
            把self.lineArray数组中最前面的addNumber个元素除去，
            然后再往self.lineArray数组中添加addNumber个元素
         */
        if (weakSelf.lineArray.count < weakSelf.maxI-addNumber && weakSelf.drawNumbers < weakSelf.maxI) {
            for (int i=0; i<addNumber; i++) {
                if (i < weakSelf.ecgArray.count) {
                    [weakSelf.lineArray addObject: weakSelf.ecgArray[i]];
                    [weakSelf.ecgArray removeObjectAtIndex:0];
                } else {
                    [weakSelf.ecgArray removeAllObjects];
                    
                    [weakSelf.lineArray addObject: @(0)];
                }
                
            }
        } else if (weakSelf.ecgArray.count > 0) {
            for (int i=0; i<addNumber; i++) {
                [weakSelf.lineArray removeObjectAtIndex:0];
                
                if (i>=weakSelf.ecgArray.count-1) {
                    [weakSelf.lineArray addObject: @(0)];
                    [weakSelf.ecgArray removeAllObjects];
                        
                } else {
                    [weakSelf.lineArray addObject: weakSelf.ecgArray[i]];
                    [weakSelf.ecgArray removeObjectAtIndex:0];
                }
            }
        } else  if (weakSelf.ecgArray.count == 0) {
            
    //        [self.lineArray addObject: @(0)];
    //        self.drawNumbers = 0;
            
        }
        
//        NSLog(@"timer - %ld",weakSelf.ecgArray.count);
        
        
        if (weakSelf.drawNumbers < weakSelf.ecgArray.count-addNumber) {
            weakSelf.drawNumbers+=addNumber;
        }else {
    //        self.drawNumbers = 0;
    //        [self.ecgArray removeAllObjects];
        }
        
        /*
         根据self.lineArray数组中的每个值计算出一个相应的CGPoint，然后把这些坐标点绘制到self上
         */
        
        if (!weakSelf.ecgArray.count) {
            return;
        }
        
        CGFloat num = (CGFloat)[weakSelf.lineArray[0] floatValue];
        CGFloat firstpointY;
        if (num >= 0) {
            firstpointY = (CGFloat)(35000 - num)/35000 * (CGFloat)(weakSelf.height/2);
        } else {
            firstpointY = fabs(num) / 35000 * (CGFloat)(weakSelf.height/2) + (CGFloat)(weakSelf.height/2);
        }
        CGFloat pointX = 0;
        [weakSelf.bezierpath moveToPoint:CGPointMake(pointX, firstpointY)];
        for (int i=1; i<weakSelf.lineArray.count; i++) {
            
            CGFloat num = (CGFloat)[weakSelf.lineArray[i] floatValue];
            pointX = pointX + weakSelf.pointMartin;
            
            if (pointX > weakSelf.width) {
                pointX = weakSelf.width;
            }
            
            CGFloat pointY;
            if (num >= 0) {
                pointY = (CGFloat)(35000 - num)/35000 * (CGFloat)(weakSelf.height/2);
            } else {
                pointY = fabs(num) / 35000 * (CGFloat)(weakSelf.height/2) + (CGFloat)(weakSelf.height/2);
            }
            
            if (pointX < weakSelf.width) {
                [weakSelf drawLineLineToPoint:CGPointMake(pointX, pointY) withLineWidth:weakSelf.penBrushWidth];
                
            }else {
                
                pointX = 0;
            }
        }
//        WEAKSELF;
    //    dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf.layer addSublayer:weakSelf.shapelayer];
    //    });
        
    });
    
    
    
}
- (void)drawLineLineToPoint:(CGPoint)endPoint withLineWidth:(CGFloat)lineWidth{

    //画折线只能用一个bezierpath对象，所以这个对象在初始化的时候创建了，而且是用全局。
    [self setBezierpathattribute:self.bezierpath toEndPoint:endPoint withLineWidth:lineWidth];
    //同上，只能用一个shapelayer对象
    [self setShapelayerattribute:self.shapelayer withBezierpath:self.bezierpath];
}

//绘制格子曲线
- (void)drawLineStartPoint:(CGPoint)startPoint toEndPoint:(CGPoint)endPoint withLineWidth:(CGFloat)lineWidth {
    
    //格子不能用一个bezierpath画，因为会首尾相连，所以要重复创建多个bezierpath对象
    UIBezierPath *bezierpath = [[UIBezierPath alloc] init];
    [bezierpath moveToPoint:startPoint];
    [self setBezierpathattribute:bezierpath toEndPoint:endPoint withLineWidth:lineWidth];
    //同上
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    [self setShapelayerattribute:shapelayer withBezierpath:bezierpath];
}
//代码抽离，设置bezierpath的相关属性
- (void)setBezierpathattribute:(UIBezierPath *)bezierpath toEndPoint:(CGPoint)endPoint withLineWidth:(CGFloat)lineWidth{
    //贝塞尔线条的宽度
    bezierpath.lineWidth = lineWidth;
    //线条拐角：kCGLineCapRound为圆角
    bezierpath.lineCapStyle = kCGLineCapRound;
    //终点处理：kCGLineCapRound为圆角
    bezierpath.lineJoinStyle = kCGLineCapRound;
    //添加坐标点
    [bezierpath addLineToPoint:endPoint];
}
//代码抽离，设置shapelayer的相关属性
- (void)setShapelayerattribute:(CAShapeLayer *)shapelayer withBezierpath:(UIBezierPath *)bezierpath{
    
    //CAShapeLayer 的背景色
    shapelayer.backgroundColor = [UIColor clearColor].CGColor;
    //CAShapeLayer填充色
    shapelayer.fillColor = [UIColor clearColor].CGColor;
    //线条拐角：kCGLineCapRound为圆角
    shapelayer.lineCap = kCALineCapRound;
    //终点处理：kCGLineCapRound为圆角
    shapelayer.lineJoin = kCALineJoinRound;
    //线条颜色：初始化时设为了绿色
    shapelayer.strokeColor = _drawerColor.CGColor;
    //CAShapeLayer的线条宽度
    shapelayer.lineWidth = bezierpath.lineWidth;
    
    //CAShapeLayer的path
    shapelayer.path = bezierpath.CGPath;
    
//    WEAKSELF;
//    dispatch_async(dispatch_get_main_queue(), ^{
        //CAShapeLayer添加到self.view上
        [self.layer addSublayer:shapelayer];
//    });
    
}
#pragma Mark -- 绘制网格
//网格分为四种线画成，一种为0.2的横线，一种为0.2的竖线，一种为0.1的横线，一种为0.1的竖线
- (void)drawGrid {
    //  显示区域的宽 和 高
    CGFloat full_height = self.frame.size.height;
    CGFloat full_width = self.frame.size.width;
    //    每一格的宽度
    CGFloat pos_x = 1;
    
    while (pos_x < full_width) {
        [self drawLineStartPoint:CGPointMake(pos_x, 1) toEndPoint:CGPointMake(pos_x, full_height) withLineWidth:0.2];
        pos_x += _pixelsPerCell;
    }
    
    CGFloat pos_y = 1;
    while (pos_y < full_height) {
        [self drawLineStartPoint:CGPointMake(full_width, pos_y) toEndPoint:CGPointMake(1, pos_y) withLineWidth:0.2];
        pos_y += _pixelsPerCell;
    }
    
    float cell_squar = 0.00;
    
    cell_squar = _pixelsPerCell / 5.00;
    
    pos_x = 1 + cell_squar;
    
    while (pos_x < full_width) {
        [self drawLineStartPoint:CGPointMake(pos_x, 1) toEndPoint:CGPointMake(pos_x, full_height) withLineWidth:0.1];
        pos_x += cell_squar;
    }
    
    pos_y = 1;
    while (pos_y < full_height) {
        [self drawLineStartPoint:CGPointMake(1, pos_y) toEndPoint:CGPointMake(full_width, pos_y) withLineWidth:0.1];
        pos_y += cell_squar;
    }

}
- (void)clearAllEcgPoint {
    [self.lineArray removeAllObjects];
    self.drawNumbers = 0;
}
- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}
@end
