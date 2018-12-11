//
//  ZZWeChatSessionViewController.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatSessionViewController.h"
#import "ZZWeChatSessionViewModel.h"
#import "ZZSessionInputView.h"
#import "ZZWeChatSessionTableView.h"
#define InputViewHeight 48
@interface ZZWeChatSessionViewController ()<ZZWeChatSessionTableViewDelegate,ZZSessionInputViewDelegate,ZZWeChatSessionViewModelDelegate>
// VM
@property (nonatomic, strong) ZZWeChatSessionViewModel * sessionViewModel;
@property (nonatomic, strong) ZZSessionInputView * inputView;
@property (nonatomic, strong) ZZWeChatSessionTableView * sessionTableView;

@end

@implementation ZZWeChatSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatNavBarViewWithTitle:self.listWeChatModel.wechat_name];
    [self showLeftButtonWithTitle:@"返回"];
    
    // 添加聊天列表
    self.sessionTableView.dataArray = [self.sessionViewModel getModelDataArrayFromLoaclTableWithWeChatID:self.listWeChatModel.wechat_id];
    [self.sessionTableView reloadData];
    [self.sessionTableView ScrollToBottom];
    // 键盘监听
    [self.sessionViewModel NotiKeyBoard];
}
#pragma mark -- 发送消息 -->> delegate
- (void)sendMessage:(NSString *)message{
    __weak typeof(self) weakSelf = self;
    [self.sessionViewModel addMessageToDBWithWeChatID:self.listWeChatModel.wechat_id Message:message success:^(ZZSessionModel * _Nonnull sessionModel) {
        [weakSelf.sessionTableView.dataArray addObject:sessionModel];
        NSIndexPath * indexpath = [NSIndexPath indexPathForRow:weakSelf.sessionTableView.dataArray.count -1 inSection:0];
        [weakSelf.sessionTableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.sessionTableView ScrollToBottom];
    } failed:^{
        
    }];
}
#pragma mark -- 滑动取消键盘 -->> delegate
- (void)tableViewResignFirstResponder{
    [self.view endEditing:YES];
}
#pragma mark -- 键盘取消  -->> delegate
- (void)keyboardWillHide{
//    self.backView.transform = CGAffineTransformMakeTranslation(0, 0);
    self.backView.frame = CGRectMake(0, 0, ZZScreenWidth, ZZScreenHeight - ZZ_Navigation_Height - 48);

}
#pragma mark -- 键盘出现  -->> delegate
- (void)keyboardWillShowToY:(CGFloat )KeyBoardY withAnimationOption:(NSInteger)animationOption andDuration:(double)timeInterval{
    
    [UIView animateWithDuration:timeInterval delay:0.0 options:animationOption << 16  animations:^{
//        if (self.sessionTableView.contentSize.height > KeyBoardY) {
//            self.backView.transform = CGAffineTransformMakeTranslation(0, KeyBoardY - self.view.frame.size.height);
        self.backView.backgroundColor = [UIColor redColor];
            self.backView.frame = CGRectMake(0, self.backView.frame.origin.y, ZZScreenWidth, self.backView.frame.size.height - 300);
//        }
    } completion:nil];
    
    [self.sessionTableView tableviewScrollToBottom];
}
#pragma make -- 布局
- (void)viewDidLayoutSubviews{
    self.inputView.frame = CGRectMake(0, self.backView.frame.size.height - InputViewHeight - iPhoneX_SafeArea_Bottom, self.backView.frame.size.width, InputViewHeight + iPhoneX_SafeArea_Bottom);
}
// 列表
-(ZZWeChatSessionTableView *)sessionTableView{
    if (_sessionTableView == nil) {
        _sessionTableView = [[ZZWeChatSessionTableView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width,self.backView.frame.size.height - InputViewHeight - iPhoneX_SafeArea_Bottom) style:UITableViewStylePlain];
        _sessionTableView.sessionDelegate = self;
        [self.backView addSubview:_sessionTableView];
    }
    return _sessionTableView;
}
// 输入框
- (UIView *)inputView{
    if (_inputView == nil) {
        _inputView = [ZZSessionInputView initInputView];
        _inputView.delegate = self;
        [self.backView addSubview:_inputView];
    }
    return _inputView;
}
//viewmodel
- (ZZWeChatSessionViewModel *)sessionViewModel{
    if (_sessionViewModel == nil) {
        _sessionViewModel = [[ZZWeChatSessionViewModel alloc]init];
        _sessionViewModel.delegate = self;
    }
    return _sessionViewModel;
}

@end
