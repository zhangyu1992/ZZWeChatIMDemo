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
@interface ZZWeChatSessionViewController ()
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
    self.sessionTableView.dataArray = [self.sessionViewModel getModelDataArrayFromLoaclTable];
    [self.sessionTableView reloadData];
    
}


- (void)viewDidLayoutSubviews{
    self.inputView.frame = CGRectMake(0, self.backView.frame.size.height - InputViewHeight - iPhoneX_SafeArea_Bottom, self.backView.frame.size.width, InputViewHeight + iPhoneX_SafeArea_Bottom);
}
// 列表
-(ZZWeChatSessionTableView *)sessionTableView{
    if (_sessionTableView == nil) {
        _sessionTableView = [[ZZWeChatSessionTableView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width,self.backView.frame.size.height - InputViewHeight - iPhoneX_SafeArea_Bottom) style:UITableViewStylePlain];
        [self.backView addSubview:_sessionTableView];
    }
    return _sessionTableView;
}
// 输入框
- (UIView *)inputView{
    if (_inputView == nil) {
        _inputView = [ZZSessionInputView initInputView];
        [self.backView addSubview:_inputView];
    }
    return _inputView;
}
//viewmodel
- (ZZWeChatSessionViewModel *)sessionViewModel{
    if (_sessionViewModel == nil) {
        _sessionViewModel = [[ZZWeChatSessionViewModel alloc]init];
    }
    return _sessionViewModel;
}
@end
