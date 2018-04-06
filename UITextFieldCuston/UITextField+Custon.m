//
//  UITextField+Custon.m
//  RAC_Login
//
//  Created by apple on 2018/4/4.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "UITextField+Custon.h"

@implementation UITextField (Custon)
+ (void)load{
    Method oldtext = class_getInstanceMethod([self class], @selector(textRectForBounds:));
    Method oldedit = class_getInstanceMethod([self class], @selector(editingRectForBounds:));
    
    Method newtext = class_getInstanceMethod([self class], @selector(dzl_textRectForBounds:));
    Method newedit = class_getInstanceMethod([self class], @selector(dzl_editingRectForBounds:));
    method_exchangeImplementations(oldtext, newtext);
    method_exchangeImplementations(oldedit, newedit);
    
}
- (void)setSpace:(CGFloat)space{
    objc_setAssociatedObject(self, @selector(space), @(space), OBJC_ASSOCIATION_COPY);
}
- (CGFloat)space{
    
  return  [objc_getAssociatedObject(self, _cmd)floatValue];
}
- (void)setPlacehloderFont:(CGFloat)placehloderFont{
    [self setValue:[UIFont systemFontOfSize:placehloderFont] forKeyPath:@"_placeholderLabel.font"];
    objc_setAssociatedObject(self, @selector(placehloderFont), @(placehloderFont), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)placehloderFont{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
- (void)setPlacehloderColor:(UIColor *)placehloderColor{
    objc_setAssociatedObject(self, @selector(placehloderColor), placehloderColor, OBJC_ASSOCIATION_COPY);
    [self setValue:placehloderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (NSString *)placehloderColor{
    
    
    return objc_getAssociatedObject(self, _cmd);
}
-(CGRect)dzl_textRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x+self.space, bounds.origin.y, bounds.size.width -self.space, bounds.size.height);
    return inset;
}
-(CGRect)dzl_editingRectForBounds:(CGRect)bounds{
    CGRect inset = CGRectMake(bounds.origin.x +self.space, bounds.origin.y, bounds.size.width -self.space, bounds.size.height);
    return inset;
}
@end
