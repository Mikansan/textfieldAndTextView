//
//  UITextField+Custon.h
//  RAC_Login
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 yl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextField (Custon)
/** *********** 光标位置 *********** */
@property (nonatomic,assign)CGFloat space;
/** *********** placehloder颜色 必须先设置placehloder 否则无效果*********** */
@property (nonatomic,copy) UIColor *placehloderColor;

/** *********** placehloder大小 必须先设置placehloder 否则无效果 *********** */
@property (nonatomic,assign) CGFloat placehloderFont;

@end
