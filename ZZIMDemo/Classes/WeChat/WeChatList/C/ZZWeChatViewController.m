
//
//  ZZWeChatViewController.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/5.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatViewController.h"
#import "ZZSearchBarView.h"
#import "ZZWeChatListTableView.h"
#import "ZZWeChatViewModel.h"
#import "ZZWeChatSessionViewController.h"
@interface ZZWeChatViewController ()<ZZWeChatListTableViewDelegate>
@property (nonatomic, strong) ZZWeChatViewModel * WeChatViewModel;
@property (nonatomic, strong) ZZWeChatListTableView * listTableView;
@end

@implementation ZZWeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatNavBarViewWithTitle:[NSString stringWithFormat:@"%@的微信",[ZZUserInfoModel shareInstance].userName]];
    
    ZZSearchBarView * searchBarView = [[ZZSearchBarView alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 44)];
    [self.backView addSubview:searchBarView];
    
    ZZWeChatListTableView * listTableView = [[ZZWeChatListTableView alloc]initWithFrame:CGRectMake(0, searchBarView.frame.size.height, searchBarView.frame.size.width,self.backView.frame.size.height - searchBarView.frame.size.height) style:UITableViewStylePlain];
    listTableView.listTableViewDelegate = self;
    listTableView.dataArray = [self.WeChatViewModel getModelDataArrayFromLoaclTable];
    [listTableView reloadData];
    [self.backView addSubview:listTableView];
    self.listTableView = listTableView;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(WebSocketDidReceiveMessageNoti:) name:@"WebSocketDidReceiveMessageNoti" object:nil];

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WebSocketDidReceiveMessageNoti" object:nil];
}
#pragma mark -- WebSocketDidReceiveMessageNoti
- (void)WebSocketDidReceiveMessageNoti:(NSNotification *)object{
    NSDictionary * dict = object.object;
    [self.WeChatViewModel WebSocketDidReceiveMessageNotiDict:dict];
    self.listTableView.dataArray = self.WeChatViewModel.dataArray;
    __weak typeof(self) weakSelf = self;

    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.listTableView reloadData];

    });
    
}
#pragma mark -- 点击cell
- (void)TableViewDidSelectedWithModel:(ZZWeChatModel *)wechatModel{
    [super.navigationController pushViewController:[self.WeChatViewModel pushSessionViewControllerWithWeChatModel:wechatModel] animated:YES];
}
-(ZZWeChatViewModel *)WeChatViewModel{
    if (_WeChatViewModel == nil) {
        _WeChatViewModel = [[ZZWeChatViewModel alloc]init];
    }
    return _WeChatViewModel;
}
@end
