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
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    return [nib instantiateWithOwner:nil options:nil].firstObject;

}
#pragma mark -- 点击非textview区域
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.inputView resignFirstResponder];
}
// 键盘监听事件
- (void)
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
