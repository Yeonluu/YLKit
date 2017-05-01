//
//  UITextField+YLMobile.m
//  YLTools
//
//  Created by Yeonluu on 15/11/24.
//  Copyright © 2015年 Yeonluu. All rights reserved.
//

#import "UITextField+YLMobile.h"

@implementation UITextField (YLMobile)

- (void)verifyMobile
{
    static NSString *lastText;
    
    UITextRange *range = self.selectedTextRange;
    self.text = [self.text formatMobile];
    if (self.text.length > 13) {
        self.text = [self.text substringToIndex:13];
    }
    NSInteger startOffset = [self offsetFromPosition:self.beginningOfDocument toPosition:range.start];
    if (startOffset == 4 || startOffset == 9) {
        if (self.text.length > lastText.length) { // 增加的情况下
            UITextPosition *position = [self positionFromPosition:range.start offset:1];
            if (position) {
                self.selectedTextRange = [self textRangeFromPosition:position toPosition:position];
            }
        }
        else {
            UITextPosition *position = [self positionFromPosition:range.start offset:-1];
            self.selectedTextRange = [self textRangeFromPosition:position toPosition:position];
        }
    }
    else {
        self.selectedTextRange = range;
    }
    lastText = self.text;
}




@end
