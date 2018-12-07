//
//  ZZWeChatSessionTableView.m
//  ZZIMDemo
//
//  Created by 张张 on 2018/12/7.
//  Copyright © 2018年 张张. All rights reserved.
//

#import "ZZWeChatSessionTableView.h"
#import "ZZSessionTableViewCell.h"
#import "ZZSessionModel.h"
@interface ZZWeChatSessionTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation ZZWeChatSessionTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZZSessionModel * sessionModel = self.dataArray[indexPath.row];
    NSString * cellId = @"ZZSessionTableViewCell_isMySelf";

    if ([sessionModel.isMySelf isEqualToString:@"1"]) {
        cellId = @"ZZSessionTableViewCell_isMySelf";
        
    }else if ([sessionModel.isMySelf isEqualToString:@"0"]) {
        cellId = @"ZZSessionTableViewCell_isOther";
    }else{
        
        cellId = @"ZZSessionTableViewCell_time";

    }
    
    ZZSessionTableViewCell * sessionCell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (sessionCell == nil) {
        sessionCell = [[ZZSessionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    sessionCell.sessionModel = sessionModel;
    
    return sessionCell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
