//
//  UITextView+PlaceHolder.m
//  JKCategories (https://github.com/shaojiankui/JKCategories)
//
//  Created by Jakey on 14/12/15.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import "UITextView+JKPlaceHolder.h"
static const char *jk_placeHolderTextView = "jk_placeHolderTextView";

@implementation UITextView (JKPlaceHolder)
- (UITextView *)jk_placeHolderTextView {
    return objc_getAssociatedObject(self, jk_placeHolderTextView);
}
- (void)setJk_placeHolderTextView:(UITextView *)placeHolderTextView {
    objc_setAssociatedObject(self, jk_placeHolderTextView, placeHolderTextView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)jk_addPlaceHolder:(NSString *)placeHolder {
    if (![self jk_placeHolderTextView]) {
        UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textView.font = self.font;
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = kPlaceholderColor;
        textView.userInteractionEnabled = NO;
        textView.text = placeHolder;
        [self addSubview:textView];
        [self setJk_placeHolderTextView:textView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
        
        [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];

    }
    self.jk_placeHolderTextView.text = placeHolder;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        NSString *newText = [change objectForKey:NSKeyValueChangeNewKey];
        if (newText.length > 0) {
            self.jk_placeHolderTextView.hidden = YES;
        }else{
            self.jk_placeHolderTextView.hidden = NO;
        }
    }
}

# pragma mark -
# pragma mark - UITextViewDelegate
- (void)textViewDidChangeText:(NSNotification *)noti {
    if (self.text.length && !self.jk_placeHolderTextView.hidden) {
        self.jk_placeHolderTextView.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)noti {
    if (self.text && [self.text isEqualToString:@""]) {
        self.jk_placeHolderTextView.hidden = NO;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.jk_placeHolderTextView) {
        [self removeObserver:self forKeyPath:@"text" context:nil];
    }
}
@end
