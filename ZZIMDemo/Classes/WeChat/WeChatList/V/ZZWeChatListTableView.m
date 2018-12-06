//
//  ZZWeChatListTableView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/6.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatListTableView.h"
#import "ZZWeChatSessionTableViewCell.h"
@interface ZZWeChatListTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZZWeChatListTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc]init];
        [self registerNib:[UINib nibWithNibName:@"ZZWeChatSessionTableViewCell" bundle:nil] forCellReuseIdentifier:@"SessionCellID"];

//        if (@available(iOS 11.0, *)){
//            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            self.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);//导航栏如果使用系统原生半透明的，top设置为64
//            self.scrollIndicatorInsets = self.contentInset;
//        }  
        
    }
    return self;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listTableViewDelegate && [self.listTableViewDelegate respondsToSelector:@selector(TableViewDidSelectedWithModel:)]) {
        ZZWeChatModel * wechatModel = self.dataArray[indexPath.row];
        [self.listTableViewDelegate TableViewDidSelectedWithModel:wechatModel];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZZWeChatSessionTableViewCell * sessionCell = [tableView dequeueReusableCellWithIdentifier:@"SessionCellID"];
    if (!sessionCell) {
        NSLog(@"sss");
    }
    ZZWeChatModel * wechatModel = self.dataArray[indexPath.row];
    sessionCell.wechatModel = wechatModel;
    return sessionCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  78;
}
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
@end
