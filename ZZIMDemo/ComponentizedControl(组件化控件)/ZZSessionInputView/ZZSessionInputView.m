//
//  ZZSessionInputView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZSessionInputView.h"
@interface ZZSessionInputView()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation ZZSessionInputView
+ (instancetype)initInputView{
    NSString *className = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:className bundle:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;

}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(sendMessage:)]) {
            [self.delegate sendMessage:textView.text];
            self.inputTextView.text = @"";
        }
        return NO;
    }
    
    return YES;
}
#pragma make -- 添加按钮
- (IBAction)clickAddItemButton:(id)sender {
}
#pragma mark -- 发送语音
- (IBAction)clickeYuYinButton:(id)sender {
}
#pragma mark -- 发送表情
- (IBAction)clickeBiaoQingButton:(id)sender {
}

@end
