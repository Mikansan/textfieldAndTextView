//
//  UITextView+Custom.h
//  rac
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UITextView (Custom)<UITextViewDelegate>
@property (nonatomic,copy) NSString *placehloder;

@property (nonatomic,strong) UIColor *placehloderColor;

@end
