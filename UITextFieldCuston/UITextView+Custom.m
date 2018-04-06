//
//  UITextView+Custom.m
//  rac
//
//  Created by apple on 2018/4/5.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UITextView+Custom.h"



@implementation UITextView (Custom)
+ (void)load{
    method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(layoutSubviews)),
                                   class_getInstanceMethod(self.class, @selector(dzl_layoutSubviews)));
    
    method_exchangeImplementations(class_getInstanceMethod([self class ], NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod([self class], @selector(dzl_dealloc)));
    
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(dzl_PlaceHolder_swizzled_setText:)));
}
- (void)dzl_dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self dzl_dealloc];
}
- (void)dzl_PlaceHolder_swizzled_setText:(NSString *)text{
    [self dzl_PlaceHolder_swizzled_setText:text];
    if (self.placehloder) {
        [self updatePlaceHolder];
    }
}
- (void)setPlacehloderColor:(UIColor *)placehloderColor{
    objc_setAssociatedObject(self, @selector(placehloderColor), placehloderColor, OBJC_ASSOCIATION_RETAIN);
    self.dzl_placeHolderLabel.textColor=placehloderColor;
}
- (UIColor *)placehloderColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setPlacehloder:(NSString *)placehloder{

    objc_setAssociatedObject(self, @selector(placehloder), placehloder, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self updatePlaceHolder];
}
- (NSString *)placehloder{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)dzl_layoutSubviews {
    if (self.placehloder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.dzl_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.dzl_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self dzl_layoutSubviews];
}
-(UILabel *)dzl_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(dzl_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(dzl_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.dzl_placeHolderLabel removeFromSuperview];
        return;
    }
    self.dzl_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.dzl_placeHolderLabel.textAlignment = self.textAlignment;
    self.dzl_placeHolderLabel.text = self.placehloder;
    [self insertSubview:self.dzl_placeHolderLabel atIndex:0];
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @"你好";
        font = textview.font;
    });
    return font;
}
@end
